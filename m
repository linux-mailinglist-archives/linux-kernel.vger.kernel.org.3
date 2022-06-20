Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF3B551218
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239784AbiFTIDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239831AbiFTICv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:02:51 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447A211A27;
        Mon, 20 Jun 2022 01:02:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LRMZT6rdcz4xZ0;
        Mon, 20 Jun 2022 18:02:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655712162;
        bh=yLr6oN2+1xTY/fIcYwD9oBugUagbqWD8uCnxze+92bU=;
        h=Date:From:To:Cc:Subject:From;
        b=I9WgX/ZnTGkuYBI4N8eOdG05EA1Jt38bFUL34iAHlH1xJIeeaBIsk5DTE+qV/SgdG
         su1quB38rFPQblC9CbuIyQqyEq1mF5nQFlZ+pCJ3azaK+VIXCNojORtJFAfdY745mc
         Ga3rw1U9Htss4RDYzhXY0POKXnWN5fpSHb7Itbi/m80z6+mPH/2tog3xxmChL3RFoP
         P44wNQBNseN776+iGEqfq8NKrD5sBVqrfTOz+B3jcKRKpv+4KYH2rzCRMOQLZhZpGg
         OZ/6zOcWqqq9NA1QiFHSYhUgswWVHfXN3QQQR0ZEvsjrHgg2JdZG37m+qjSG7GDVR3
         zC4OYOl9uVDQw==
Date:   Mon, 20 Jun 2022 18:02:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>,
        Wang Jianjian <wangjianjian3@huawei.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the origin tree
Message-ID: <20220620180240.1eb2cf90@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uQbwBF/j8+zgA/eN+vQ6Hxb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uQbwBF/j8+zgA/eN+vQ6Hxb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the origin tree, today's linux-next build (htmldocs)
produced these warnings:

Documentation/filesystems/ext4/ifork.rst:5: WARNING: Malformed table.

+---------------------+----------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------+
| i.i_block Offset   | Where It Points                                     =
                                                                           =
                                                                           =
                   |
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
| 0 to 11             | Direct map to file blocks 0 to 11.                 =
                                                                           =
                                                                           =
                    |
+---------------------+----------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------+
| 12                  | Indirect block: (file blocks 12 to (``$block_size``=
 / 4) + 11, or 12 to 1035 if 4KiB blocks)                                  =
                                                                           =
                    |
|                     |                                                    =
                                                                           =
                                                                           =
                    |
|                     | +------------------------------+-------------------=
-------------------------------------------------+                         =
                                                                           =
                    |
|                     | | Indirect Block Offset        | Where It Points   =
                                                 |                         =
                                                                           =
                    |
|                     | +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D+                                                  =
                                                                      |
|                     | | 0 to (``$block_size`` / 4)   | Direct map to (``$=
block_size`` / 4) blocks (1024 if 4KiB blocks)   |                         =
                                                                           =
                    |
|                     | +------------------------------+-------------------=
-------------------------------------------------+                         =
                                                                           =
                    |
+---------------------+----------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------+
| 13                  | Double-indirect block: (file blocks ``$block_size``=
/4 + 12 to (``$block_size`` / 4) ^ 2 + (``$block_size`` / 4) + 11, or 1036 =
to 1049611 if 4KiB blocks)                                                 =
                    |
|                     |                                                    =
                                                                           =
                                                                           =
                    |
|                     | +--------------------------------+-----------------=
---------------------------------------------------------------------------=
-------------+                                                             =
                    |
|                     | | Double Indirect Block Offset   | Where It Points =
                                                                           =
             |                                                             =
                    |
|                     | +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+        =
                                                                         |
|                     | | 0 to (``$block_size`` / 4)     | Map to (``$block=
_size`` / 4) indirect blocks (1024 if 4KiB blocks)                         =
             |                                                             =
                    |
|                     | |                                |                 =
                                                                           =
             |                                                             =
                    |
|                     | |                                | +---------------=
---------------+-----------------------------------------------------------=
---------+   |                                                             =
                    |
|                     | |                                | | Indirect Block=
 Offset        | Where It Points                                           =
         |   |                                                             =
                    |
|                     | |                                | +=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+   |             =
                                                                    |
|                     | |                                | | 0 to (``$block=
_size`` / 4)   | Direct map to (``$block_size`` / 4) blocks (1024 if 4KiB b=
locks)   |   |                                                             =
                    |
|                     | |                                | +---------------=
---------------+-----------------------------------------------------------=
---------+   |                                                             =
                    |
|                     | +--------------------------------+-----------------=
---------------------------------------------------------------------------=
-------------+                                                             =
                    |
+---------------------+----------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------+
| 14                  | Triple-indirect block: (file blocks (``$block_size`=
` / 4) ^ 2 + (``$block_size`` / 4) + 12 to (``$block_size`` / 4) ^ 3 + (``$=
block_size`` / 4) ^ 2 + (``$block_size`` / 4) + 12, or 1049612 to 107479143=
6 if 4KiB blocks)   |
|                     |                                                    =
                                                                           =
                                                                           =
                    |
|                     | +--------------------------------+-----------------=
---------------------------------------------------------------------------=
----------------------------------------------------+                      =
                    |
|                     | | Triple Indirect Block Offset   | Where It Points =
                                                                           =
                                                    |                      =
                    |
|                     | +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+                                         =
 |
|                     | | 0 to (``$block_size`` / 4)     | Map to (``$block=
_size`` / 4) double indirect blocks (1024 if 4KiB blocks)                  =
                                                    |                      =
                    |
|                     | |                                |                 =
                                                                           =
                                                    |                      =
                    |
|                     | |                                | +---------------=
-----------------+---------------------------------------------------------=
------------------------------------------------+   |                      =
                    |
|                     | |                                | | Double Indirec=
t Block Offset   | Where It Points                                         =
                                                |   |                      =
                    |
|                     | |                                | +=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D+   |                                          |
|                     | |                                | | 0 to (``$block=
_size`` / 4)     | Map to (``$block_size`` / 4) indirect blocks (1024 if 4K=
iB blocks)                                      |   |                      =
                    |
|                     | |                                | |               =
                 |                                                         =
                                                |   |                      =
                    |
|                     | |                                | |               =
                 | +------------------------------+------------------------=
--------------------------------------------+   |   |                      =
                    |
|                     | |                                | |               =
                 | | Indirect Block Offset        | Where It Points        =
                                            |   |   |                      =
                    |
|                     | |                                | |               =
                 | +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D+   |   |                                          |
|                     | |                                | |               =
                 | | 0 to (``$block_size`` / 4)   | Direct map to (``$block=
_size`` / 4) blocks (1024 if 4KiB blocks)   |   |   |                      =
                    |
|                     | |                                | |               =
                 | +------------------------------+------------------------=
--------------------------------------------+   |   |                      =
                    |
|                     | |                                | +---------------=
-----------------+---------------------------------------------------------=
------------------------------------------------+   |                      =
                    |
|                     | +--------------------------------+-----------------=
---------------------------------------------------------------------------=
----------------------------------------------------+                      =
                    |
+---------------------+----------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------+
Documentation/filesystems/ext4/blockmap.rst:3: WARNING: Malformed table.

+---------------------+----------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------+
| i.i_block Offset   | Where It Points                                     =
                                                                           =
                                                                           =
                   |
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
| 0 to 11             | Direct map to file blocks 0 to 11.                 =
                                                                           =
                                                                           =
                    |
+---------------------+----------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------+
| 12                  | Indirect block: (file blocks 12 to (``$block_size``=
 / 4) + 11, or 12 to 1035 if 4KiB blocks)                                  =
                                                                           =
                    |
|                     |                                                    =
                                                                           =
                                                                           =
                    |
|                     | +------------------------------+-------------------=
-------------------------------------------------+                         =
                                                                           =
                    |
|                     | | Indirect Block Offset        | Where It Points   =
                                                 |                         =
                                                                           =
                    |
|                     | +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D+                                                  =
                                                                      |
|                     | | 0 to (``$block_size`` / 4)   | Direct map to (``$=
block_size`` / 4) blocks (1024 if 4KiB blocks)   |                         =
                                                                           =
                    |
|                     | +------------------------------+-------------------=
-------------------------------------------------+                         =
                                                                           =
                    |
+---------------------+----------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------+
| 13                  | Double-indirect block: (file blocks ``$block_size``=
/4 + 12 to (``$block_size`` / 4) ^ 2 + (``$block_size`` / 4) + 11, or 1036 =
to 1049611 if 4KiB blocks)                                                 =
                    |
|                     |                                                    =
                                                                           =
                                                                           =
                    |
|                     | +--------------------------------+-----------------=
---------------------------------------------------------------------------=
-------------+                                                             =
                    |
|                     | | Double Indirect Block Offset   | Where It Points =
                                                                           =
             |                                                             =
                    |
|                     | +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+        =
                                                                         |
|                     | | 0 to (``$block_size`` / 4)     | Map to (``$block=
_size`` / 4) indirect blocks (1024 if 4KiB blocks)                         =
             |                                                             =
                    |
|                     | |                                |                 =
                                                                           =
             |                                                             =
                    |
|                     | |                                | +---------------=
---------------+-----------------------------------------------------------=
---------+   |                                                             =
                    |
|                     | |                                | | Indirect Block=
 Offset        | Where It Points                                           =
         |   |                                                             =
                    |
|                     | |                                | +=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+   |             =
                                                                    |
|                     | |                                | | 0 to (``$block=
_size`` / 4)   | Direct map to (``$block_size`` / 4) blocks (1024 if 4KiB b=
locks)   |   |                                                             =
                    |
|                     | |                                | +---------------=
---------------+-----------------------------------------------------------=
---------+   |                                                             =
                    |
|                     | +--------------------------------+-----------------=
---------------------------------------------------------------------------=
-------------+                                                             =
                    |
+---------------------+----------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------+
| 14                  | Triple-indirect block: (file blocks (``$block_size`=
` / 4) ^ 2 + (``$block_size`` / 4) + 12 to (``$block_size`` / 4) ^ 3 + (``$=
block_size`` / 4) ^ 2 + (``$block_size`` / 4) + 12, or 1049612 to 107479143=
6 if 4KiB blocks)   |
|                     |                                                    =
                                                                           =
                                                                           =
                    |
|                     | +--------------------------------+-----------------=
---------------------------------------------------------------------------=
----------------------------------------------------+                      =
                    |
|                     | | Triple Indirect Block Offset   | Where It Points =
                                                                           =
                                                    |                      =
                    |
|                     | +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+                                         =
 |
|                     | | 0 to (``$block_size`` / 4)     | Map to (``$block=
_size`` / 4) double indirect blocks (1024 if 4KiB blocks)                  =
                                                    |                      =
                    |
|                     | |                                |                 =
                                                                           =
                                                    |                      =
                    |
|                     | |                                | +---------------=
-----------------+---------------------------------------------------------=
------------------------------------------------+   |                      =
                    |
|                     | |                                | | Double Indirec=
t Block Offset   | Where It Points                                         =
                                                |   |                      =
                    |
|                     | |                                | +=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D+   |                                          |
|                     | |                                | | 0 to (``$block=
_size`` / 4)     | Map to (``$block_size`` / 4) indirect blocks (1024 if 4K=
iB blocks)                                      |   |                      =
                    |
|                     | |                                | |               =
                 |                                                         =
                                                |   |                      =
                    |
|                     | |                                | |               =
                 | +------------------------------+------------------------=
--------------------------------------------+   |   |                      =
                    |
|                     | |                                | |               =
                 | | Indirect Block Offset        | Where It Points        =
                                            |   |   |                      =
                    |
|                     | |                                | |               =
                 | +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D+   |   |                                          |
|                     | |                                | |               =
                 | | 0 to (``$block_size`` / 4)   | Direct map to (``$block=
_size`` / 4) blocks (1024 if 4KiB blocks)   |   |   |                      =
                    |
|                     | |                                | |               =
                 | +------------------------------+------------------------=
--------------------------------------------+   |   |                      =
                    |
|                     | |                                | +---------------=
-----------------+---------------------------------------------------------=
------------------------------------------------+   |                      =
                    |
|                     | +--------------------------------+-----------------=
---------------------------------------------------------------------------=
----------------------------------------------------+                      =
                    |
+---------------------+----------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------+
Documentation/filesystems/ext4/dynamic.rst:5: WARNING: Malformed table.

+---------------------+----------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------+
| i.i_block Offset   | Where It Points                                     =
                                                                           =
                                                                           =
                   |
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
| 0 to 11             | Direct map to file blocks 0 to 11.                 =
                                                                           =
                                                                           =
                    |
+---------------------+----------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------+
| 12                  | Indirect block: (file blocks 12 to (``$block_size``=
 / 4) + 11, or 12 to 1035 if 4KiB blocks)                                  =
                                                                           =
                    |
|                     |                                                    =
                                                                           =
                                                                           =
                    |
|                     | +------------------------------+-------------------=
-------------------------------------------------+                         =
                                                                           =
                    |
|                     | | Indirect Block Offset        | Where It Points   =
                                                 |                         =
                                                                           =
                    |
|                     | +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D+                                                  =
                                                                      |
|                     | | 0 to (``$block_size`` / 4)   | Direct map to (``$=
block_size`` / 4) blocks (1024 if 4KiB blocks)   |                         =
                                                                           =
                    |
|                     | +------------------------------+-------------------=
-------------------------------------------------+                         =
                                                                           =
                    |
+---------------------+----------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------+
| 13                  | Double-indirect block: (file blocks ``$block_size``=
/4 + 12 to (``$block_size`` / 4) ^ 2 + (``$block_size`` / 4) + 11, or 1036 =
to 1049611 if 4KiB blocks)                                                 =
                    |
|                     |                                                    =
                                                                           =
                                                                           =
                    |
|                     | +--------------------------------+-----------------=
---------------------------------------------------------------------------=
-------------+                                                             =
                    |
|                     | | Double Indirect Block Offset   | Where It Points =
                                                                           =
             |                                                             =
                    |
|                     | +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+        =
                                                                         |
|                     | | 0 to (``$block_size`` / 4)     | Map to (``$block=
_size`` / 4) indirect blocks (1024 if 4KiB blocks)                         =
             |                                                             =
                    |
|                     | |                                |                 =
                                                                           =
             |                                                             =
                    |
|                     | |                                | +---------------=
---------------+-----------------------------------------------------------=
---------+   |                                                             =
                    |
|                     | |                                | | Indirect Block=
 Offset        | Where It Points                                           =
         |   |                                                             =
                    |
|                     | |                                | +=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+   |             =
                                                                    |
|                     | |                                | | 0 to (``$block=
_size`` / 4)   | Direct map to (``$block_size`` / 4) blocks (1024 if 4KiB b=
locks)   |   |                                                             =
                    |
|                     | |                                | +---------------=
---------------+-----------------------------------------------------------=
---------+   |                                                             =
                    |
|                     | +--------------------------------+-----------------=
---------------------------------------------------------------------------=
-------------+                                                             =
                    |
+---------------------+----------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------+
| 14                  | Triple-indirect block: (file blocks (``$block_size`=
` / 4) ^ 2 + (``$block_size`` / 4) + 12 to (``$block_size`` / 4) ^ 3 + (``$=
block_size`` / 4) ^ 2 + (``$block_size`` / 4) + 12, or 1049612 to 107479143=
6 if 4KiB blocks)   |
|                     |                                                    =
                                                                           =
                                                                           =
                    |
|                     | +--------------------------------+-----------------=
---------------------------------------------------------------------------=
----------------------------------------------------+                      =
                    |
|                     | | Triple Indirect Block Offset   | Where It Points =
                                                                           =
                                                    |                      =
                    |
|                     | +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+                                         =
 |
|                     | | 0 to (``$block_size`` / 4)     | Map to (``$block=
_size`` / 4) double indirect blocks (1024 if 4KiB blocks)                  =
                                                    |                      =
                    |
|                     | |                                |                 =
                                                                           =
                                                    |                      =
                    |
|                     | |                                | +---------------=
-----------------+---------------------------------------------------------=
------------------------------------------------+   |                      =
                    |
|                     | |                                | | Double Indirec=
t Block Offset   | Where It Points                                         =
                                                |   |                      =
                    |
|                     | |                                | +=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D+   |                                          |
|                     | |                                | | 0 to (``$block=
_size`` / 4)     | Map to (``$block_size`` / 4) indirect blocks (1024 if 4K=
iB blocks)                                      |   |                      =
                    |
|                     | |                                | |               =
                 |                                                         =
                                                |   |                      =
                    |
|                     | |                                | |               =
                 | +------------------------------+------------------------=
--------------------------------------------+   |   |                      =
                    |
|                     | |                                | |               =
                 | | Indirect Block Offset        | Where It Points        =
                                            |   |   |                      =
                    |
|                     | |                                | |               =
                 | +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D+   |   |                                          |
|                     | |                                | |               =
                 | | 0 to (``$block_size`` / 4)   | Direct map to (``$block=
_size`` / 4) blocks (1024 if 4KiB blocks)   |   |   |                      =
                    |
|                     | |                                | |               =
                 | +------------------------------+------------------------=
--------------------------------------------+   |   |                      =
                    |
|                     | |                                | +---------------=
-----------------+---------------------------------------------------------=
------------------------------------------------+   |                      =
                    |
|                     | +--------------------------------+-----------------=
---------------------------------------------------------------------------=
----------------------------------------------------+                      =
                    |
+---------------------+----------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------+

Introduced by commit

  3103084afcf2 ("ext4, doc: remove unnecessary escaping")

--=20
Cheers,
Stephen Rothwell

--Sig_/uQbwBF/j8+zgA/eN+vQ6Hxb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKwKaAACgkQAVBC80lX
0GwcoQgAo2lczCZvuMeSa9MhtxOVwqPBWQRteJhqRBunmkCbfHF+CS5GJ0aqjuiv
yqWdyvW4gP5xIivMNNYU8RVOt5XB68AvWRE53/lkDF/c3ZznJsryOUr17Ac9c9xP
gy1VL4ARn5M+XDYqaUVrH3KIwnO7ON28C8TOhuJDIWHFiDrD0f8wfjHRSpETz7bJ
GyMicsEmcqtXUujtRv6auoPa+itAO3YMGiL2w1vQ2dfUOXYOd12EMlTCe8EXd7jv
K1UoSP78VKQUnTFDauL9MkaPT97zofyPdnaguEwCg7DSpu0UAOwuosEvrpzcMlKP
dygG8ZAGlugksILDMaVXEe9gm4PxRA==
=4wu0
-----END PGP SIGNATURE-----

--Sig_/uQbwBF/j8+zgA/eN+vQ6Hxb--

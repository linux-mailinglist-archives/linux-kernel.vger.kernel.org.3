Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AA84D4452
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 11:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237713AbiCJKOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 05:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiCJKOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:14:23 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5C6F1AE6;
        Thu, 10 Mar 2022 02:13:22 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KDlJF0pjvz4xLS;
        Thu, 10 Mar 2022 21:13:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646907197;
        bh=a5TnBRyicVOOYJK/trLhEn9JHRFaDj9hNHLBtmLoVrY=;
        h=Date:From:To:Cc:Subject:From;
        b=SD+W3LVyaSkjNub8+NIjiyCU432/ZNHreoGaiNid0OS874hcL9hBn1XnxpAFObjsD
         KtcSG56mzSS56KcaZbGDZDJmKXgwvr3pdc1DrUpUN3xY/T6WUBZKjpMK0HpvoDYUc4
         fuw24VMdXp8bqL40xKV87ZkSLqHR6WdLxPPB1/7V0ENa4jV6+wAVVRbMTHa8drysge
         Uk5cJkmJ7MAMYAI3eZfusW4FMjfYNhOsUNkW01F/lHY63e10tssPgV3kylvCLfakl7
         JEqGDQcmNwLE6ps8WOawIrr2hzpBUx4uApKoJ1k4ShykvCX8LeYCqgSzuPNSuBgX1Z
         AlMuc8vh9CGJg==
Date:   Thu, 10 Mar 2022 21:13:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Karolina Drobnik <karolinadrobnik@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the memblock tree
Message-ID: <20220310211315.595cca09@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DB3xEc/Xqmv5Cank09OenCB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DB3xEc/Xqmv5Cank09OenCB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the memblock tree, today's linux-next build (KCONFIG_NAME)
produced this warning:

Documentation/vm/index.rst:12: WARNING: toctree contains reference to nonex=
isting document 'vm/memblock-sim'

Introduced by commit

  cc5a1e382509 ("memblock tests: Add TODO and README files")

--=20
Cheers,
Stephen Rothwell

--Sig_/DB3xEc/Xqmv5Cank09OenCB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIpzzsACgkQAVBC80lX
0Gx4pQf+JL9D3WN+6B5y09I0ivcyIyq0FhvkmshFDDxg8aAm4+TRtMkCKWYPUAxJ
O1IFPhEWUIWAWyWm6scOCDpSN3O7u/TgDVuvTTXmqcoJMK5uxgmKlVIZ+hT520v2
FmgTIk2hUDftnTZ9KP/mITeqogE6p0oNgxCln7ATwD9sirNDZ5EwXd/9V2xR3+MC
qEu0LUNU9U998DyGX8ElYYzh5S7wkO/hRfpXpATsK7vucrLulOZDc6i02KKt1dsW
5t6zl4hc92ICCymYlzO8OGOL53MiCOKM6FRLcbkO7V55Qy3aDNzGOo0U/Jgw52wB
cNDw8GuUlFn44YmJ5C3GvGnvS1FNJw==
=Cq1/
-----END PGP SIGNATURE-----

--Sig_/DB3xEc/Xqmv5Cank09OenCB--

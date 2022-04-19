Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAFB5070F3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350939AbiDSOub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiDSOu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:50:28 -0400
Received: from m228-62.mailgun.net (m228-62.mailgun.net [159.135.228.62])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id AF6F2220FA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:47:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=codeagain.dev; q=dns/txt;
 s=smtp; t=1650379665; h=Content-Type: MIME-Version: Message-ID:
 Subject: Subject: To: To: From: From: Date: Sender: Sender;
 bh=t6kTMyvUWlvIMDWuRhK4XgWIlIwiKrKDcGeXHhzBiD8=; b=puOKekT3++UUCw2kBN9kv55SpbG6V+UJA3jbZJJvCuMPLTVkQY3DPSj9U78+w/RZMiUO+CWx
 CvrMgQlDjoOa13hunemNwei7pEAwiNyw7uVUS+mrXa3iX4mjPWA1FwuTkX4j/I06fHuh79SK
 g4LARxtMGeixFFcRgXVFGGgBs0XXep9TNwwLSbLg7n9I0vaQGrc4yLHBuv6FdqIXwO1knmF/
 6if56WRYsd/QDepkq1cXF0w1Keo2LxE1Xbz6CM1Mk5M3c5mgtGxxL2fhN2XhFo6Kj/5Wtc1H
 BUTuGMNOAdLWHdpsXVxiYYeo5if3cBE+DO69dMYteoo0OwGNwRj3kA==
X-Mailgun-Sending-Ip: 159.135.228.62
X-Mailgun-Sid: WyJkNDU4NiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWM2ZCJd
Received: from AN5Bruno (dynamic-user.170.84.57.33.mhnet.com.br
 [170.84.57.33]) by smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 625ecb8f225c4690820943df (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Tue, 19 Apr 2022 14:47:43 GMT
Sender: codeagain@codeagain.dev
Date:   Tue, 19 Apr 2022 11:47:38 -0300
From:   Bruno Moreira-Guedes <codeagain@codeagain.dev>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: [PATCH v2 0/2] Docs: Update information at changes.rst
Message-ID: <cover.1650376049.git.codeagain@codeagain.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dir4xtje6p7ta4sv"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dir4xtje6p7ta4sv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add and update information at 'Documentation/process/changes.rst'. The
text has outdated kernel version and misses the 'cpio' build
requirement, necessary for the `kernel/gen_kheaders.sh` script called by
the install target.

The PATCH 1/2 fixes the missing cpio requirement, while PATCH 2/2 fixes
the kernel version reference.

Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>
---
CHANGE SUMMARY
   version: v1  v2
[PATCH 1/2] *   -
[PATCH 1/2] *   *

CHANGELOG
[PATCH 1/2] Docs: Add cpio requirement to changes.rst
        v2:
                - No changes
[PATCH 2/2] Docs: Replace version by 'current' in changes.rst
        v2:
                - Renamed from 'Docs: Update kernel series in
                changes.rst'
                - Changed approach from the original, replacing 4.x by
                5.x, to using 'current', as suggested by Matthew Wilcox.
---
Bruno Moreira-Guedes (2):
  Docs: Add cpio requirement to changes.rst
  Docs: Replace version by 'current' in changes.rst

 Documentation/process/changes.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--
2.35.3


--dir4xtje6p7ta4sv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQTUrsHCxGmQ5vyKRAZtd3tyEY2kgUCYl7LigAKCRAZtd3tyEY2
klMEAQD7GhNwW69LkRR+NiYprOk0un5iHf7yuuhTWrDAsi8v3QEArHCMNqA6rFQt
uW9gRYzpdqGJa979zNlFM32xj9Zacww=
=XfWs
-----END PGP SIGNATURE-----

--dir4xtje6p7ta4sv--

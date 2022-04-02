Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA8C4EFDB3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 03:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239329AbiDBBUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 21:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbiDBBUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 21:20:16 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D97D6272
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 18:18:22 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id p4-20020a17090ad30400b001c7ca87c05bso6693645pju.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 18:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=vmXDNGRwxvJV5bPtlpMkGelkiXgueKiUQe5KobqRJ/4=;
        b=NONBFM1nyA+/a7X1odEhyipKm4YHgfni3MSDXOxb6N8k5EUYH4qxjuoDq91WCTjCCD
         cOdWI2ICvv9C6sOLtkNw0eCSqL/I8XXSMfhyEuImA7vgv1rE328wNQIRD/YD0buKz0Bb
         P7Cx7V6CYDgfLMbHlTWyzbVut0ZPAfsrjYmHD7rc4+uwNldLB14weJKla4ntc8EwEuTH
         dkUJH/VlFeQpwqp3hk+XFt1y4V2pyinXZgLrV+EZ4Vyy4boyROI8ZGF6SGRAlcnyYi3u
         utaG2CJDL3dJHfhr3/svxdKf5SMbutxmype1xxxsy7mT21Pq/TuLLlrCbjcbd5C7/xdA
         uKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=vmXDNGRwxvJV5bPtlpMkGelkiXgueKiUQe5KobqRJ/4=;
        b=mv3TnRuBVVm9c1OPEfXtdEJ1RWD7MDz8rlTdKvjwvrAWGqA4zvSMHWCBawnIAhAm9o
         flhqxB3Rp1UXrurAYZNY6B0Yn4LECgOLsGP3030a2zRViCAeeU5T1XQL/uBhVthc6Khs
         LEZsWSAiwRoV5AgXaqRNio/yniGgeDSeK/lQgGE7/cnq+Lg+fNl9A+vUzcIOcg8QzJzh
         o+cxwN6NjAUdbvetRPHQkNFzJlcpQa4OkfH52D+r8Wm0WGy6fBWz01/lOeKYTQG9nGdl
         VTfNOUVt+cYFsSftkBapjNZoVQpzqQ9+33wzktqC3dhPtxgO03zU127Px8CimJawWhrH
         kMIg==
X-Gm-Message-State: AOAM532a7slP5HvO/EToV6dGRPL4GoA1XhqCAQrHBjJ6bF0NH7mNGbGy
        lkr5gQHqHkSqnI1/AE6RP06IqQ==
X-Google-Smtp-Source: ABdhPJy+bnbcPBXRDI8Tq5oOepqEmiWjEb84NCjTl7AXKfF37y7W7ZWFY8F4nxzb2yiKOYPjDVi0AQ==
X-Received: by 2002:a17:902:e851:b0:156:3cbd:22d0 with SMTP id t17-20020a170902e85100b001563cbd22d0mr18151216plg.33.1648862301431;
        Fri, 01 Apr 2022 18:18:21 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:b43e:b2a3:f165:61a1])
        by smtp.gmail.com with ESMTPSA id ot17-20020a17090b3b5100b001c746bfba10sm15020578pjb.35.2022.04.01.18.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 18:18:19 -0700 (PDT)
Date:   Fri, 1 Apr 2022 18:18:13 -0700
From:   Benson Leung <bleung@google.com>
To:     torvalds@linux-foundation.org
Cc:     pmalani@chromium.org, bleung@chromium.org, bleung@google.com,
        bleung@kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, tzungbi@kernel.org
Subject: [GIT PULL] chrome-platform changes for v5.18
Message-ID: <YkekVRh9Ixdfa5qL@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AJDRZfkVlpKTNT5V"
Content-Disposition: inline
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AJDRZfkVlpKTNT5V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here's chrome-platform's changes for v5.18-rc1.

Of note, the last two commits of this PR had to be reworded (actually just
the second to last one) since it hit linux-next for a minor commit message
fixup. Content wise, the two are the same as they are on linux-next right n=
ow.

Thanks,
Benson

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git t=
ags/tag-chrome-platform-for-v5.18

for you to fetch changes up to 0e8eb5e8acbad19ac2e1856b2fb2320184299b33:

  platform/chrome: cros_ec_debugfs: detach log reader wq from devm (2022-03=
-31 16:56:48 -0700)

----------------------------------------------------------------
chrome platform changes for 5.18

cros_ec_typec:
* platform/chrome: cros_ec_typec: Check for EC device - Fix a crash when us=
ing
  the cros_ec_typec driver on older hardware not capable of typec commands.
* Make try power role optional.
* Mux configuration reorganization series from Prashant.

cros_ec_debugfs:
* Fix use after free. Thanks Tzung-bi.

sensorhub:
* cros_ec_sensorhub fixup - Split trace include file

misc:
* Add new mailing list for chrome-platform development.
  chrome-platform@lists.linux.dev. Now with patchwork!

----------------------------------------------------------------
Benson Leung (1):
      MAINTAINERS: platform-chrome: Add new chrome-platform@lists.linux.dev=
 list

Gwendal Grignou (1):
      platform: chrome: Split trace include file

Prashant Malani (6):
      platform/chrome: cros_ec_typec: Make try power role optional
      platform/chrome: cros_ec_typec: Check for EC device
      platform/chrome: cros_ec_typec: Move mux flag checks
      platform/chrome: cros_ec_typec: Get mux state inside configure_mux
      platform/chrome: cros_ec_typec: Configure muxes at start of port upda=
te
      platform/chrome: cros_ec_typec: Update mux flags during partner remov=
al

Tzung-Bi Shih (1):
      platform/chrome: cros_ec_debugfs: detach log reader wq from devm

 MAINTAINERS                                       |   5 +
 drivers/platform/chrome/Makefile                  |   3 +-
 drivers/platform/chrome/cros_ec_debugfs.c         |  12 +--
 drivers/platform/chrome/cros_ec_sensorhub_ring.c  |   3 +-
 drivers/platform/chrome/cros_ec_sensorhub_trace.h | 123 ++++++++++++++++++=
++++
 drivers/platform/chrome/cros_ec_trace.h           |  95 -----------------
 drivers/platform/chrome/cros_ec_typec.c           |  97 +++++++++--------
 7 files changed, 186 insertions(+), 152 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_ec_sensorhub_trace.h

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--AJDRZfkVlpKTNT5V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYkekVQAKCRBzbaomhzOw
wvn5AQDWkhaopvlzCZno1F1xRKy2RLugOwMNRZTw7KIVbpaoaQD+PGaExSaXegl7
4SpRXDVGTgKnfg183XocNISMZzJ3+wI=
=J0ly
-----END PGP SIGNATURE-----

--AJDRZfkVlpKTNT5V--

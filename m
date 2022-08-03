Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E00588634
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 06:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbiHCENG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 00:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbiHCENC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 00:13:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7905447BBA
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 21:13:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8F54612E4
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 04:13:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AF5C43146;
        Wed,  3 Aug 2022 04:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659499980;
        bh=SvGVzKWmN4GNKfHbAT3CERRiu9R0YWc3B8gflnIPfHU=;
        h=Date:From:To:Cc:Subject:From;
        b=f9d7KlCnmhT7qVAJeF11oTWRdQ64p9A1jSsyrBK45/leTqLucMqUGv76VEtl0omy4
         Rt6kPrNz7IAnU1pCnfJjR0f6aAMu5lscHu/qPTYpCbtE4MUBnWE/7BurFEqRzb/xi8
         xJimgQSUTM7n3hPzFOuQccNrLWrXaWMu8ygEkMgNxcLKJzRUpcI+f/6yoP8DRzF1Wc
         alTgIWr1WMEQ7Mwju1x6Y8pdLJ79DHiB6v2itTatCvk19r2XloTB3yUP4aMO7aE1O5
         cpDVzMfCzsz4Pz8vrLw7y0tKZY4b8IuF56mzztz62QaZYgoHvFp1HQr0aOEII1sIfK
         RnNHZmAL8gu7w==
Date:   Wed, 3 Aug 2022 04:12:56 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     pmalani@chromium.org, bleung@chromium.org, groeck@chromium.org,
        tzungbi@kernel.org, linux-kernel@vger.kernel.org,
        chrome-platform@lists.linux.dev
Subject: [GIT PULL] chrome-platform changes for v5.20
Message-ID: <Yun1yFEsqpF59Tdy@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uoQWHsGDqpU1z+Ga"
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uoQWHsGDqpU1z+Ga
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus,

Please pull chrome-platform updates for v5.20.

Thanks,
TzungBi


The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git/ =
tags/tag-chrome-platform-for-v5.20

for you to fetch changes up to afef1e1a0223623d063a6df51dbc342c9517b948:

  platform/chrome: cros_kunit_util: add default value for `msg->result` (20=
22-07-21 08:49:28 +0000)

----------------------------------------------------------------
chrome platform changes for 5.20

cros_ec_proto:
* Leverage Kunit and add Kunit test cases.
* Clean-ups.
* Fix typo.

cros_ec_commands:
* Fix typo.
* Fix compile errors.

cros_kbd_led_backlight:
* Support OF match.
* Support EC PWM backend.

cros_ec:
* Always expose the last resume result to fix sleep hang detection on
  ARM-based chromebooks.

wilco_ec:
* Fix typo.

cros_ec_typec:
* Clean-ups.
* Use Type-C framework utilities to manage altmode structs.

----------------------------------------------------------------
Colin Ian King (1):
      platform/chrome: cros_ec_proto: Fix spelling mistake "unknwon" -> "un=
known"

Jiang Jian (1):
      platform/chrome: wilco_ec: event: Fix typo in comment

N=EDcolas F. R. A. Prado (1):
      platform/chrome: cros_ec_typec: Use dev_err_probe on port register fa=
il

Prashant Malani (5):
      regulator: cros-ec: Use common cros_ec_command()
      platform/chrome: cros_ec_proto: Rename cros_ec_command function
      platform/chrome: cros_ec_proto: Update size arg types
      platform/chrome: cros_ec_typec: Rename port altmode array
      platform/chrome: cros_ec_typec: Register port altmodes

Stephen Boyd (1):
      platform/chrome: cros_ec: Always expose last resume result

Tzung-Bi Shih (49):
      platform/chrome: cros_ec_proto: add Kunit tests for cros_ec_prepare_t=
x()
      platform/chrome: cros_ec_proto: factor legacy out from cros_ec_prepar=
e_tx()
      platform/chrome: cros_ec_proto: update cros_ec_check_result() comment
      platform/chrome: cros_ec_proto: add Kunit tests for cros_ec_check_res=
ult()
      platform/chrome: cros_kbd_led_backlight: sort headers alphabetically
      platform/chrome: cros_kbd_led_backlight: separate ACPI backend
      dt-bindings: add google,cros-kbd-led-backlight
      platform/chrome: cros_kbd_led_backlight: support OF match
      platform/chrome: cros_kbd_led_backlight: support EC PWM backend
      platform/chrome: cros_ec_commands: fix compile errors
      platform/chrome: cros_ec_proto: add Kunit tests for cros_ec_query_all=
()
      platform/chrome: use macros for passthru indexes
      platform/chrome: cros_ec_proto: assign buffer size from protocol info
      platform/chrome: cros_ec_proto: remove redundant NULL check
      platform/chrome: cros_ec_proto: use cros_ec_map_error()
      platform/chrome: cros_ec_proto: separate cros_ec_get_proto_info()
      platform/chrome: cros_ec_proto: add Kunit tests for getting proto info
      platform/chrome: cros_ec_proto: handle empty payload in getting proto=
 info
      platform/chrome: cros_ec_proto: separate cros_ec_get_proto_info_legac=
y()
      platform/chrome: cros_ec_proto: add Kunit test for getting legacy info
      platform/chrome: cros_ec_proto: handle empty payload in getting info =
legacy
      platform/chrome: cros_ec_proto: don't show MKBP version if unsupported
      platform/chrome: cros_ec_proto: return 0 on getting cmd mask success
      platform/chrome: cros_ec_proto: add Kunit test for getting cmd mask e=
rror
      platform/chrome: cros_ec_proto: check `msg->result` in getting cmd ma=
sk
      platform/chrome: cros_ec_proto: add Kunit tests for getting cmd mask
      platform/chrome: cros_ec_proto: handle empty payload in getting cmd m=
ask
      platform/chrome: cros_ec_proto: return 0 on getting wake mask success
      platform/chrome: cros_ec_proto: add Kunit test for getting wake mask
      platform/chrome: cros_ec_proto: handle empty payload in getting wake =
mask
      platform/chrome: cros_ec_proto: add "cros_ec_" prefix to send_command=
()
      platform/chrome: cros_ec_proto: add Kunit tests for cros_ec_cmd_xfer()
      platform/chrome: cros_ec_proto: add Kunit tests for cros_ec_send_comm=
and()
      platform/chrome: cros_ec_proto: separate cros_ec_xfer_command()
      platform/chrome: cros_ec_proto: separate cros_ec_wait_until_complete()
      platform/chrome: cros_ec_proto: change Kunit expectation when timed o=
ut
      platform/chrome: cros_ec_proto: return -EAGAIN when retries timed out
      platform/chrome: cros_ec_proto: add Kunit test for empty payload
      platform/chrome: cros_ec_proto: return -EPROTO if empty payload
      platform/chrome: cros_ec_proto: add Kunit tests for cmd_xfer_status
      platform/chrome: cros_ec_proto: add Kunit test for cros_ec_map_error()
      platform/chrome: cros_ec_proto: add Kunit tests for get_next_event
      platform/chrome: cros_ec_proto: add Kunit tests for get_host_event
      platform/chrome: cros_ec_proto: add Kunit tests for check_features
      platform/chrome: cros_ec_proto: add Kunit tests for get_sensor_count
      platform/chrome: cros_ec_proto: add Kunit test for cros_ec_cmd()
      platform/chrome: cros_kbd_led_backlight: fix build warning
      platform/chrome: merge Kunit utils and test cases
      platform/chrome: cros_kunit_util: add default value for `msg->result`

Xiang wangx (1):
      platform/chrome: cros_ec_commands: Fix syntax errors in comments

 .../chrome/google,cros-kbd-led-backlight.yaml      |   35 +
 .../devicetree/bindings/mfd/google,cros-ec.yaml    |    3 +
 drivers/mfd/cros_ec_dev.c                          |    4 +-
 drivers/platform/chrome/Kconfig                    |   11 +-
 drivers/platform/chrome/Makefile                   |    5 +
 drivers/platform/chrome/cros_ec.c                  |   11 +-
 drivers/platform/chrome/cros_ec_proto.c            |  473 ++--
 drivers/platform/chrome/cros_ec_proto_test.c       | 2753 ++++++++++++++++=
++++
 drivers/platform/chrome/cros_ec_trace.h            |    8 +-
 drivers/platform/chrome/cros_ec_typec.c            |   93 +-
 drivers/platform/chrome/cros_kbd_led_backlight.c   |  196 +-
 drivers/platform/chrome/cros_kunit_util.c          |  130 +
 drivers/platform/chrome/cros_kunit_util.h          |   48 +
 drivers/platform/chrome/cros_usbpd_notify.c        |    4 +-
 drivers/platform/chrome/wilco_ec/event.c           |    2 +-
 drivers/regulator/cros-ec-regulator.c              |   36 +-
 include/linux/platform_data/cros_ec_commands.h     |    6 +-
 include/linux/platform_data/cros_ec_proto.h        |    7 +-
 18 files changed, 3490 insertions(+), 335 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-kb=
d-led-backlight.yaml
 create mode 100644 drivers/platform/chrome/cros_ec_proto_test.c
 create mode 100644 drivers/platform/chrome/cros_kunit_util.c
 create mode 100644 drivers/platform/chrome/cros_kunit_util.h

--uoQWHsGDqpU1z+Ga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQS0yQeDP3cjLyifNRUrxTEGBto89AUCYun1xQAKCRArxTEGBto8
9HxeAP4rAbwrEjg4ZzNyPLHRqMygr08vOw25SrkwfI0kqDMcuQEAmy+WVD1oHb+a
ob3Q6ZDs4gBTGu6PVFc/errsBN8M6Qk=
=xFyU
-----END PGP SIGNATURE-----

--uoQWHsGDqpU1z+Ga--

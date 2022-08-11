Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47E159092D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 01:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbiHKX2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 19:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbiHKX2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:28:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EE3A1D12;
        Thu, 11 Aug 2022 16:28:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E73B615A7;
        Thu, 11 Aug 2022 23:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3A2C433D6;
        Thu, 11 Aug 2022 23:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660260511;
        bh=K1pnTJgHJXUMiZr3606Z/nzCRJeYnqTRByEoRzKd/7o=;
        h=Date:From:To:Cc:Subject:From;
        b=HIRXHDytkWGeWocT5Y6EwMm+CJbDrEa9j6XN5O8Eu8tggS/sy0AK5M7lpp0JVOfij
         GwbRDM16ekgHuzl4PZQ1EH23m7mMfd9mN69W1oPazdRXc+UJQox5HATkzxiEJSVxYI
         88GgES/deOD/kahxMXRW7AsPEbUN2eK5TUzlaTUl5bulNsFfJh7TPxICCoxKbcO6o7
         mKG3A0N2DqpMXWqbGBWvEJobFXCOJiK6Oij5pEwBQqo6yb6il5WS5IZJJYOOkLOFaP
         RtkxSi4lDc8QQFsLFAIjgyoXswZqpDLP6/zE/WkyRPx3ZFACHiZpnOAPcsMe7ao55z
         iEjSRKK7LSOFA==
Received: by mercury (Postfix, from userid 1000)
        id D59D6106085B; Fri, 12 Aug 2022 01:28:27 +0200 (CEST)
Date:   Fri, 12 Aug 2022 01:28:27 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 6.0
Message-ID: <20220811232827.e4ib5raltkbacmgc@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pz5mswhhqer2puzz"
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pz5mswhhqer2puzz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Sorry, a bit late this time. On the positive site all patches have
been in linux-next for a month.

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.0

for you to fetch changes up to c9d8468158adca6dffd2ff5b1befd35f75568b10:

  power: supply: olpc_battery: Hold the reference returned by of_find_compatible_node (2022-07-17 01:05:54 +0200)

----------------------------------------------------------------
power supply and reset changes for the v6.0 series

power-supply core:
 - none

drivers:
 - pwr-mlxbf: new reset driver for Mellanox BlueField
 - at91-reset: SAMA7G5 support
 - ab8500: continue refurbishing
 - misc. minor fixes

----------------------------------------------------------------
Asmaa Mnebhi (2):
      power: reset: pwr-mlxbf: add BlueField SoC power control driver
      power: reset: pwr-mlxbf: add missing include

Claudiu Beznea (7):
      dt-bindings: reset: convert Atmel/Microchip reset controller to YAML
      dt-bindings: reset: atmel,at91sam9260-reset: add sama7g5 bindings
      dt-bindings: reset: add sama7g5 definitions
      power: reset: at91-reset: document structures and enums
      power: reset: at91-reset: add at91_reset_data
      power: reset: at91-reset: add reset_controller_dev support
      power: reset: at91-reset: add support for SAMA7G5

Jiang Jian (1):
      power: supply: ab8500_fg: drop duplicated 'is' in comment

Julia Lawall (1):
      power: supply: lp8788: fix typo in comment

Krzysztof Kozlowski (5):
      dt-bindings: power: supply: bq24190: use regulator schema for child node
      dt-bindings: power: supply: qcom,pm8941: use regulator schema for child node
      dt-bindings: power: supply: qcom,pm8941: document usb-charge-current-limit
      dt-bindings: power: supply: summit,smb347: use absolute path to schema
      dt-bindings: power: reset: qcom,pshold: convert to dtschema

Liang He (1):
      power: supply: olpc_battery: Hold the reference returned by of_find_compatible_node

Linus Walleij (4):
      power: supply: ab8500: Respect charge_restart_voltage_uv
      power: supply: ab8500: Exit maintenance if too low voltage
      power: supply: ab8500: Add MAINTAINERS entry
      power: supply: ab8500: Drop external charger leftovers

Luca Ceresoli (1):
      power: supply: max77976: update Luca Ceresoli's e-mail address

Schspa Shi (1):
      power: supply: Fix typo in power_supply_check_supplies

Sebastian Reichel (1):
      Merge tag 'at91-reset-sama7g5-signed' into psy-next

Tetsuo Handa (1):
      power: supply: ab8500: Remove flush_scheduled_work() call.

Tom Rix (1):
      power: reset: pwr-mlxbf: change rst_pwr_hid and low_pwr_hid from global to local variables

Xiang wangx (1):
      power: supply: bq24257: Fix syntax error in comments

Xiaohui Zhang (1):
      power: supply: cros_peripheral: Use struct_size() helper in kzalloc()

Yang Li (1):
      power: supply: Remove unnecessary print function dev_err()

Zheng Bin (1):
      power: supply: ab8500: add missing destroy_workqueue in ab8500_charger_bind

 .../devicetree/bindings/arm/atmel-sysregs.txt      |  15 -
 .../bindings/power/reset/msm-poweroff.txt          |  17 -
 .../bindings/power/reset/qcom,pshold.yaml          |  35 ++
 .../devicetree/bindings/power/supply/bq24190.yaml  |   2 +-
 .../bindings/power/supply/qcom,pm8941-charger.yaml |   9 +-
 .../power/supply/summit,smb347-charger.yaml        |   2 +-
 .../bindings/reset/atmel,at91sam9260-reset.yaml    |  68 +++
 MAINTAINERS                                        |   5 +
 drivers/power/reset/Kconfig                        |   6 +
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/at91-reset.c                   | 184 +++++++-
 drivers/power/reset/pwr-mlxbf.c                    |  97 ++++
 drivers/power/supply/ab8500-chargalg.h             |   4 -
 drivers/power/supply/ab8500_btemp.c                |   1 -
 drivers/power/supply/ab8500_chargalg.c             |  70 ++-
 drivers/power/supply/ab8500_charger.c              |  48 +-
 drivers/power/supply/ab8500_fg.c                   |   3 +-
 drivers/power/supply/bq24257_charger.c             |   2 +-
 drivers/power/supply/cros_peripheral_charger.c     |   2 +-
 drivers/power/supply/goldfish_battery.c            |   4 +-
 drivers/power/supply/lp8788-charger.c              |   2 +-
 drivers/power/supply/max77976_charger.c            |   4 +-
 drivers/power/supply/olpc_battery.c                |   5 +-
 drivers/power/supply/pm2301_charger.h              | 492 ---------------------
 drivers/power/supply/power_supply_core.c           |   4 +-
 include/dt-bindings/reset/sama7g5-reset.h          |  10 +
 26 files changed, 462 insertions(+), 630 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/reset/msm-poweroff.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/qcom,pshold.yaml
 create mode 100644 Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
 create mode 100644 drivers/power/reset/pwr-mlxbf.c
 delete mode 100644 drivers/power/supply/pm2301_charger.h
 create mode 100644 include/dt-bindings/reset/sama7g5-reset.h

--pz5mswhhqer2puzz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmL1kJQACgkQ2O7X88g7
+poIZg//SqTkcIA8c0em5LVmjHI/o+4aXUrchTkkmCoEJZxv5/flXUh+tcu70B75
dxxFTkdZ0mc+cjz3tB1i5wm0cy4mFQdQ4oGCDJrJh7dWbBxKCqVKlDmnYBnn3D1v
0yib7CBKuEBhYRKCePWjpKgf3cw+K+kBJRf0BmMYlsTbPRPRgK4kNkfhZ+P/hmQF
d/buaLIGdqzEd2EeYqcryJv0cv29O/USXflxnHJnsmA+jhzmPwJXqcs9gF/www5M
BhuVK3jBHeTPA2KXRiuSOgk4ZKfI72qMHT3p+Nu5rgspIE9ZNrlXmoVybIDo9oBC
MfFKjHIkxOk5TjvbOHgJpwodlpNMKswrLKQUjo8uD158wNCY1lCN15Xy8nwtQeM4
EtYz/BDoKf+97sPkflam9ZGXEnbHe6ExYCVOfmgcBaoWJuJTgHL3OHjyopBYIs1h
l1DYNM8J+CzhOheYFyDRFFuwK9og5His/jSw4zE9tLMVNPE7vD5ziV7tCaiYJlRA
zo6yZsA81wxIXGrvQFHq8Koz79lN71RRFo8hNCAtMUfkrmzqjjjOmCh8WgUo7QUB
IMj3QTAcmLxNEgGzkEm159njygK7O8rVXCtaiX62vGtdFaRqQNKnmCJf0DEgyuOR
Ao6l6NMs2wtqgvAeI0OVjREPVRsCshzkEk8nW+hvcd7wyYhaMYU=
=erri
-----END PGP SIGNATURE-----

--pz5mswhhqer2puzz--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8457B4C23F1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 07:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiBXGNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 01:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiBXGM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 01:12:59 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057C423400B;
        Wed, 23 Feb 2022 22:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645683132;
        bh=REa265nvh/komFD1FcTmecbeNI5/kSivlQxcjQiFZVY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Gn2h/79sOF7rYJ/e+u3Q8BwcS/vNJeOXyeXY1+wIr/uxAwDqeUDbXnSC8QKP7GjHc
         2voLo0styqVF+jyBSIUzU5ZvzOOcIaMlYnA+gtnQ5R4+r9XgA0cooqADf6jYAovLOv
         iatW3bp9v1qJIsUPTVYXrswHJuIBsER/rVv+VR+w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N3bSj-1oM3rj0XDv-010cxR; Thu, 24 Feb 2022 07:12:12 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] hwmon: (sch5627) Add pwmX_auto_channels_temp attributes
Date:   Thu, 24 Feb 2022 07:12:08 +0100
Message-Id: <20220224061210.16452-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BhB520CYWe2mZI4epOlS9mHcJhtS+XBEdoV+hY7QubDV/OWdK18
 vzGayCqEYMbQFDmH61Slh0wOd/jDD3+jkl94i7KnOI6+jby/hXlRw+szwWBb5RNetP4wXzi
 I9VRir36hit0dgiivCqd3kQqOesi2RueDv9JGjn9Gn4s5ifnfZNQD8T3Pvq45VGSC/yoy77
 qS9af6lFWAxzsO390Km+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oWGNQgN8jSQ=:HulgLGAOPEHJuH2j11YeUD
 B6Q6pPE5/NSaUbw3H5AGMGAOlx3NXHIoBpAxJ/qcuUZGGP9EPP8Yf84b0DG44wv1MDHExp0sB
 HncL6DS3sYnAiNPLWVzAZr1Lg9V1AjCY79DYXGyNrRFdWCz95aJW0x5cuQEmqyLA/UvjoroaN
 QsBZBTuZ9YqPX0oUGtKp9ZLAUnD637zKegC34nxkY5Ma3cB49NsKNd+Ns1J3BNhgrIF3TGqJe
 1lEp0Uhgw2I7czQfi5tjWGRx5DWWCCw9DzxTFsFKO5U0LWvqmQIqEt5WKOAxTGt1b2d8M0cVk
 RZoTXeBvSikRVN+zvwJqM8AZr+EbIid0UPs1mSHC8IfIyvpxtplwgMEI1o1YZPn8aJiEEO1FY
 H8jyWZhowwsi5RHid3Q67asbP8x0QdzXlf6TquujmjIIk7zVZrsmSh8gqzadaMklJsvAaHz75
 UaKWlwvJ7OINhihHAzlL5J92EsaCJqG0G/dDOS/zOrW2n1Eb1ECFn+ppbF2HgSQQebEeOd20r
 nYvZUmV1R+0uZAfbLDYGVomNFkyVkMVUXCX6A+/thlJLbhScfXThIKnSwIw3FuedYlILmdYa8
 EpW88f1B9ffKIIxUD4KVS3TaA15oL85Bt2fucd+XYDjdBLVImhHQ6KBYw2M7bwnzclNGhgfjL
 obr9tCqr10WYr2TgRh2938zKR5NqfBtLxGl8KNbnQbwUbzeT8gzAqawl65EEOcdKk4FWWgvoK
 rA+j+p+lED0vb8/3OGWvxI2fkLZV4AT3s6Jr3F31X/sHz8Y6wTRtBM6VvtJFfpGlthQ374obf
 wat+eTD5V47MYFOjaHWVihNQ0ACrdwL7mH44XTW0dMCNB1Jm6ffsu4mjtSmVm3Khmbn4p68iV
 usVvrDbIjQ/mu7/MgBrGo2u8YIdBK4E0eHB4XF3H/QmCsrZFMDiL05/pt29cN93putBxFEkwc
 uF/L/75pwMv9ie02waMIl+xMc22fq68xEA9oNmkVJporacMGo3weU/OYAcjcZY9++N5k/xHJl
 NsZhbsU/9xchsVWUK/NElzsQHPhI4ZZk3jvSxDBItrfjiJgIUI9MdrED2Ipn4Kd+vcMPlUDSt
 mXFKWpHfuep4fg=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After doing some research, i found out that Fujitsu's hardware
mointoring solution inside the SCH5627 exports data thru
registers 0xA0 - 0xA3 regarding the mapping between temperature
sensors and fans. If those registers are set to 0, the fans
are forced to full speed.
The first patch adds support for pwmX_auto_channels_temp
attributes to the hwmon core, while the second patch does
extend the sch5627 driver.

Both patches have been tested on a Fujitsu Esprimo P720.

=2D--
Changes in v2:
- acquire mutex before doing register reads/writes

Armin Wolf (2):
  hwmon: (core) Add support for pwm auto channels attribute
  hwmon: (sch5627) Add pwmX_auto_channels_temp support

 Documentation/hwmon/sch5627.rst |  4 +++
 drivers/hwmon/hwmon.c           |  1 +
 drivers/hwmon/sch5627.c         | 61 +++++++++++++++++++++++++++++++++
 include/linux/hwmon.h           |  2 ++
 4 files changed, 68 insertions(+)

=2D-
2.30.2


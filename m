Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F474C1E49
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 23:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243400AbiBWWO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 17:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiBWWO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 17:14:28 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840A3506E4;
        Wed, 23 Feb 2022 14:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645654422;
        bh=e1Qpgyy9c7ybbmmSpZcNg5SSFRKWKCVoD2clpfa3YK4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=AjW69cVhlVolCuH5jD/p/25Qi7+l+q8TWqrcmSGnFeSV88Ndy4VRXD9NpiYWpkZHg
         9ECsapJlq396LSwZFrBU3CA9B9TvjXXST+HAuvabsMz5L+l7qxEOEt7RFEIrp4bkr9
         bzmL6GzOIvUUewjVddXy3n4YE35CAdKt6U+YRtWo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N4Qwg-1oKqY40dok-011VMV; Wed, 23 Feb 2022 23:13:42 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] hwmon: (sch5627) Add pwmX_auto_channels_temp attributes
Date:   Wed, 23 Feb 2022 23:13:32 +0100
Message-Id: <20220223221334.3993-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QGqBXWIE1EBPX2Uv6sbG3SNqZEuKFKuNu/gJLxAgLPFOyxX/xzI
 /wIh0xpbJynCwUkOyhm6meE8HonTEF4Ocd3RJtwgkim06rntcajF9/EHcY06xSuEocuU4co
 CWBmgrdnDdvBvNwvAXI1cfFjJrGPvNneJ/nwVruvC1T07ZBHURqA6a50eySO7lrXnmJtW6d
 oB0gJqc/6EU+8fBGRzrwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PM9bRmqb1As=:aWE9QkA0VcY+3cFqbxWsE2
 O78JQIkJ/cRdlHnRQQQgCYtN9O00b5nke9N3bkTzXcE972xyL7oTJ6TC07Ua/l1BrBSO488+S
 CO4meb37F3uQl3Cqb+Y7Ur3Znmb1YkvU/yvWJncJuOGGetdyL1rqq5Bno7y7LfzH8XlKt3osy
 r+YhQk8g1bUoNdyJ6aHAwgtFJGYfJbw4DNXBB6Aou2a9tj2ll4EO+QNYY/9Hhoz75pd59WMdD
 EJS7izHRwG2bgp7ZK5XMgpqnIvgnCRg3+NyK1HhNKxmsjPSC/5Xew0k+8zJ6/ysJX/sVaL/xI
 0q8uSZoxHxVMlTcv0VbgtCddAhylybfqLTZOhaZ5sSZ0F1xYt8mN9jlB/8P7uUptQehpA8ils
 +2omBbWSm3dMlMmwfG6EmVYWm0tbihJMnXrC+yjwYDQwItFsgEqRmyrYKbdtfmxPvit1LsjgN
 v8V0/KSbh6P9vEjhwjyLgaqvfQAYe3Xdm53yPMVpVdVtzVOa3sGfdwVAyPK0OEkPtAOGSt2mC
 qpj7DQzCHnfTR+cock+Pjkpdq8UNKVbwEX+nI8sSIHuiwFeHNt2OyL68AM5IYaz5gAaNG+vxT
 79xXyjnchxmG6itWmEu4HAhglGJG9J/IGr2JIrUpUYMVOu19mrzie6ow8T3jNcJuczg2AdhHX
 LgmWphTEGX9cNoB0UhMRzz8hvwlMxl7my8kjD2/wyEP1QcOcHNPI5I/phoApBS2yeUz9M0dWB
 /NIIJInMnxov6a/Nu5g5SBrvFU+UR8rQV8ECTxkEJphM1T3Z6hO+g6Ece+gbfwr5r/swNRAIj
 VhQBdoObMWPg40ysUFSg66xK5SkjkPkJkDdwWppZTPoQ3YWbyzLnrZOpsgSdLWfQ7S50VjOxz
 YIvAePn/XNrQJVdqSqKOgTbQhUMSB1iSDiub5ZlwhU+Iwu5GS3llJG+G0xhkXFyM2XLCrMwjn
 LZnS4w9/m5C9bRPVcs1vSta63OEi/t4Xia61gHqI5Ohug15LFgJcwnM2BLsHjDY6uZNDjfTdX
 c+EDPTzRRfgJ1Hq3N+HSumb885MI/fr70YtWnJyGiPEBftOHSKPrGU9wrGh1wrB6gS7I6G8wh
 al+tIjwmThvuaA=
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

Armin Wolf (2):
  hwmon: (core) Add support for pwm auto channels attribute
  hwmon: (sch5627) Add pwmX_auto_channels_temp support

 Documentation/hwmon/sch5627.rst |  4 +++
 drivers/hwmon/hwmon.c           |  1 +
 drivers/hwmon/sch5627.c         | 53 +++++++++++++++++++++++++++++++++
 include/linux/hwmon.h           |  2 ++
 4 files changed, 60 insertions(+)

=2D-
2.30.2


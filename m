Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EEE50D2FA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 17:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiDXPv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 11:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiDXPvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 11:51:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7554C37034;
        Sun, 24 Apr 2022 08:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650815310;
        bh=dM80CE4Hxz/HXDZj9f/WT2hePOrxx+6iBlw5smBqUvU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=hhtVxyceNEJdNpBy0WWvKBsXz53J08znmTwbSELoVwwweiXvNUMrhq4pmWEQG3sOO
         p03JiFwI0oCpi/MKf5SW99vnCcfhJHZE92hvgya7+lOXomXkK9Da2mPOCQJHfe6Wzr
         UY1V6emEzAjngBpn08oZaaIkvYZlWBwzT9NyIntQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mk0NU-1oBMWc0mj2-00kNDx; Sun, 24 Apr 2022 17:48:30 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (dell-smm) Update Documentation regarding firmware bugs
Date:   Sun, 24 Apr 2022 17:48:24 +0200
Message-Id: <20220424154824.9396-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rV6AgNBN3rAfW2XGLJW3HrQQl4Cp8C0wEE2JUTT4+NaBbl9WpQs
 s0ChGobIykCt2Wqv5lYw5t2EwnlE3DAHuYUdugBWI7ccIeUay3i+pl0+wOW1Qu+iWuTCrbX
 M1uuqY5E066+aGE32SuCamOjn2MFno5fucxD5qW7yBqpyaezRbUehbN27YhY/oS7jkbmbQ/
 aLYkUBrkzOTCQOp2PG6nA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CYclG5nPRS4=:yiJ/bFmOQH4r2vgZbqFoRO
 5LMUsQljpVKXOMUFAcUMnPdw5PDRo/oATaCSykndNIUJlA8FmxmUEdFPBhCw0v0Vd9whJRGjA
 /akmXbBjnSCca0aQWyFZN07QfhQ8TAelA3vZDk+wEwycrMwtCLGtC9BPz+KrLrlN3U15bf1W7
 /v42em3m0Ds3BrVt/HHZWbsl8AeKPA5qwzEHFywgDOq/7/IbQYMBr67KRa6yRg7ewjNHfm7no
 bNrWz/w7FQ6JfEgOjxZMjH+MIsUEUJM0UOjdYlzj5FakBowdyQBsjjFaPbX61+oF7BaihVsLj
 /m2+jnDHkEtc/qyI8EZr6cz0lD5EtB7R5+mMjXWXrPklaNz4Bk+0mfcpO20v5FrLCtteqNuAk
 4f6kNshPBkjeVz9sYB0M9L/IcfWmqUPCpaN4aGvF/RX69e5vBZPaw3+R1WEZyy9j3qZcDCQmJ
 tzB4BZCOoJvZzZ2qgUxmvaFpgt80aMgY6oM8YNA4ixo8SEnX6dCiASfpaUQcC2YVH+x16mZH4
 cAKy1iQxwVPnFwhcTMi5SiLsmueAJZ6XKZ5woClhW7lrRadzfzxD5Du/FR980YAwJcijLWRBM
 yn9+UnHhRIYV1afzqEY4VwtA9JPTRJ6qGs2H+NLmOksThnX2TYIASloscwuava71Y/oDOMRut
 YcS+523FtCRLUUdCazgaJViZvRmdFAtst9mfWCp2b6wn6vJJoqC4jzvtTayAAJ1ydstOkQJuP
 babbzlhkoUZImhY3okczUeXVtVTvmBSDe15w6zU5/bc6jZxRABa9FQrf3DS8FrWmUetYQfk3G
 WM5jvYcahLYdAHmS0S13OnBmXxF+p75u1z49k8OsGvUGNsivrFeJ4JUbMQOTWqdcCaNWx2g7X
 gu4jXoXmH7uyTXogt5ursDwZ9N909kJhf29ZLWivzQ+79CE/QhpQhvWBRGfNjQUxqXQBh/Gnz
 F/ZTMszVVG9LSpS9mC4IXiwqK+SmOiI+98aCcUuP8L8j7Z/XvkDcV5K6Ij1lSD9Ngt4i1eyqu
 MEqLUQ9ZecLy4dyRpU3zYdVN9X9qrmOp1XBXKxlc21SZTv+7KAeqROHUdCid//RUbPNS+ovh2
 Np+Bwjl/ea9mg8=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding the Inspiron 3505 to the fan type blacklist,
the Documentation was not updated to mention the firmware
bug on this machine.
Fix that.

Fixes: 6ba463edccb9 (hwmon: (dell-smm) Add Inspiron 3505 to fan type black=
list)
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/hwmon/dell-smm-hwmon.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/=
dell-smm-hwmon.rst
index 41839b7de2c1..e5d85e40972c 100644
=2D-- a/Documentation/hwmon/dell-smm-hwmon.rst
+++ b/Documentation/hwmon/dell-smm-hwmon.rst
@@ -331,6 +331,8 @@ Reading of fan types causes erratic fan behaviour.    =
  Studio XPS 8000

                                                         Inspiron 580

+                                                        Inspiron 3505
+
 Fan-related SMM calls take too long (about 500ms).      Inspiron 7720

                                                         Vostro 3360
=2D-
2.30.2


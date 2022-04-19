Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A4E507BCD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357934AbiDSVT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242666AbiDSVTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:19:25 -0400
Received: from mout.gmx.com (mout.gmx.com [74.208.4.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0831C31DD5;
        Tue, 19 Apr 2022 14:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.com;
        s=dbd5af2cbaf7; t=1650403000;
        bh=oVIT34MDI5tMjIfJ6/0G80LIiT9URv2qJqg4DFh6JfQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=I4v64/XaX/n3w8YY2WTWh2y5gNZEWcDd+jiOGnVMYXTEfjcTTOPZVxp0beMO5KNSL
         6yDg//t1URzL1DrIcFBTtd5+bYUSPB1szD8snIf2lQanrvIK2YynAQlwironsK64Fp
         JOSXZ4HI9KY+9Zhs+EK8W5iXL/J+bWrJdXJKIW9M=
X-UI-Sender-Class: 214d933f-fd2f-45c7-a636-f5d79ae31a79
Received: from localhost ([94.175.88.251]) by smtp.mail.com (mrgmxus005
 [74.208.5.15]) with ESMTPSA (Nemesis) id 0MCKtL-1npPeg2wwz-0095mB; Tue, 19
 Apr 2022 23:16:40 +0200
From:   Rebecca White <rtw@null.net>
To:     david.rheinsberg@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rebecca White <rtw@null.net>
Subject: [PATCH] HID: hid-wiimote-core: Removed Unnecessary Braces
Date:   Tue, 19 Apr 2022 22:15:30 +0100
Message-Id: <20220419211530.10123-1-rtw@null.net>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g2/vYMUR0GCcQ918V5nyH7XuDMQumRX8jlky07kBA53hhgoNlKR
 tvWwe00llJkRxHX+q+JOKdg5ViJjRyrX19J93S0YRiif2j4g+5aKXbDP3RnIIol4Aeqwm0W
 9M5v+kbJexaQB5nsW+yGERTprl9sZcPUvppqHJDYGeb2ZOQfZRFRxBfKcO2RS4n9E4mrBxr
 qqjajod5PXvqoetln6RgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u/2bk/s/tck=:ODoZX7jpBXeYocLduJmPt8
 r4DxbZcMq2CZ9nIhLxm4iL4mH+xCHwA47b02rU+sCnGv1D32DKoepuwwANB6rAwInYeGvi+FQ
 WTEmDzXtCca8/MoIkbZHfe1dL9VzyK2edMuY5lI3q4duykcnIl737ZwXw6g8KHUdByGyJ4yQL
 gxtzRHiT2EX1sG6xhft1CV/+l0wJxmT6lcoRt3rSV6RTfQdAfXql1D+ZNelNnzEougULgNyOB
 1KgS0CTcahHOHCwemisBQqLR173OpWHvtDffvzoaVKoGUIAFAOUWuGjgiY4r1D3JTaJGj8i9R
 mr1h18odZ5Ea1/dPhjS4S6ArH+msCO9Imxtt0777DpJjz1npTKAeef+MFlRIMNKpHmCH4aSZZ
 c/D2s3meXoEwtPZNIkRPCE4QDAW+LOspshY7CyzGlroDO9iPOxsJnXaph8kmJmqxF6i6Q31/N
 3ZT5YUl2YCMJ5pEpQDUh/ivx2A3dVo/JxYyhYneXdpUIVTgq37PtgiaV706YhjZwd4cATQP/r
 3uL0vRA5mZhlXTAtzsrFwgDYGvi7GssmqWnpT7AH7Wq5OzpgSsWMaSqGxXoMo9a1abL5Uxzc6
 6Mc13AFlbkxgfodvFYAIfpyXv6ftz7A1Upp/FZTyE6NWXCRZXejJnVykK2ZKeGJ3D7WR1Pbqn
 1Ho8y4gAlu3Dxqm9WPQng11WcMghiOqiHjR0By78Kgew2tefGgIVBHJGDdt7d90T5MuIEnR7F
 XFOg2hN2huUCuSdEouYrVG6wZCtMhmIsNmXyNQeIjgWP9snuF1WrNvg1rSwP78ROAppwd0Gvv
 cFRd3lE0OY2Dc2WjgIYehr4Te+7HhEFraprH2E/Ui7KYNFkCxZYZF1etNlgN+V+qjGSqfd/bt
 V4MOtSSMvjYkQuuS/HmFcxEOK4y4SO6GZ8EkJfl1DEIcWHAw+dlu6X42Zze3TT9UPd7WJWIYi
 V95HNfQMzR1PynDlCmIis2gDvqUJEdmd+lAKXq0xN5/RsyG1/GkvJWr60oTOOQj62+n1sU6+b
 G84k/0OfEiepT6QtfpthaeRV4/9fHuWJXx+hauuLGds8+3j9pJ+Srxk6VjHlTZNhnQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unnecessary braces around a single line if/else statement

Signed-off-by: Rebecca White <rtw@null.net>
=2D--
 drivers/hid/hid-wiimote-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core=
.c
index 4399d6c6a..84180f3b8 100644
=2D-- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -1681,11 +1681,10 @@ static ssize_t wiimote_ext_store(struct device *de=
v,
 {
 	struct wiimote_data *wdata =3D dev_to_wii(dev);

-	if (!strcmp(buf, "scan")) {
+	if (!strcmp(buf, "scan"))
 		wiimote_schedule(wdata);
-	} else {
+	else
 		return -EINVAL;
-	}

 	return strnlen(buf, PAGE_SIZE);
 }
=2D-
2.35.3


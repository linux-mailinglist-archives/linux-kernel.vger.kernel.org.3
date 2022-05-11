Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256055237B0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343960AbiEKPtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343928AbiEKPtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:49:47 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2095.outbound.protection.outlook.com [40.92.107.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD876B0B2;
        Wed, 11 May 2022 08:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lULVfr/EeMQ0Zw6aa3OBW7TXV7g8IGvdXWX04w5Kz4uu+k9b131KwuCIvMAtDFxlvcT8hn2rIQRFefkpboJ1FaFhdm9e0Co/fn89yH4AxsOdcgKgWYh53xUZSg7scCphL6jLTiUt8bKx27V+db9cm8yTcHnO9PoX6bFBfYgztnafn+Sm2ku15Bt1EymUmWRVEKt3O3+RxqUFMYHNWJ66pxiVhTP1bIXYDFGnuPHLOpWKwnt5gRb8xmFim2HWTZSla5tug58wclJsQopZws+h9pu2xrTrYSlpK5vL2VcyO+G69zYZPYPGliiqLnlp1iVCqXgL4pPUmTS3HBNX29GquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9r+fRVuuYJ2bIwcJqK0CdJFiJpG1MxQ0xoMFwRCXuis=;
 b=aZoJsUrIpE19NpsSABNgmHjt2zwGQ0e+Vr6Z871yZocmV/ze+V901KZeXPRnXWxjM0RL4LuYBaonFg7lApgNWLbALZyt8+A7DIfxafGKTiLQ3HDbesqBEuskk+edD1YnX09Zx86iRe1rAn+qoc1Uc0n/BiD9STmGZh2tT9298O8XdEPFouzByYzEoYC1jiphIuCIriNkaxpAzWA2rkJZGsSzatAB8JnIHSL9AqfMZ0bPcjYL07pFHz85BAYRs9//PQz3mHqaujPM1M5/17ecJKQXqMaXexpXGHxqThgiBRzNi/KyX0jumgNFCMIDbpfrVvQWQT+x9w8Y1gFy9Mbh1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9r+fRVuuYJ2bIwcJqK0CdJFiJpG1MxQ0xoMFwRCXuis=;
 b=lL658ocmzsnNXrIXAtovBdkNg/Ln/NrHSywUV73F3mjl3KHOj+KEC4mj8vWvnjYPKSkfLVkPvJGBqDO8McKWSHsuIF8UPec1+S9F07Tb1EVnP2Rk/Y7vv8JqZYhk9FWbCGtxaQwtghxiM1wkkU/V4inc9aWnV8tBRVqC/1xhA3rf1wdNGAGtrWteKL1UYEiXbf52zPFxJOYXDGkAEzECHjo5FDCUILVc12uEcDzPVj0+A24Eeu1omdRq92ZCZnAbWOAktFBqi5EMxx8hyAHANP6KQ2s70fLQXM7jwRmetjTSTpwEYav/91A2yK/s9DX+KqN85yQBGTpMsJw9+U3z6A==
Received: from TYZPR01MB3935.apcprd01.prod.exchangelabs.com
 (2603:1096:400:8::7) by TY2PR0101MB3358.apcprd01.prod.exchangelabs.com
 (2603:1096:404:f0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 15:49:44 +0000
Received: from TYZPR01MB3935.apcprd01.prod.exchangelabs.com
 ([fe80::451c:ecce:b777:d937]) by TYZPR01MB3935.apcprd01.prod.exchangelabs.com
 ([fe80::451c:ecce:b777:d937%7]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 15:49:44 +0000
Message-ID: <TYZPR01MB39354534E2F9EE4E022DDAFFF8C89@TYZPR01MB3935.apcprd01.prod.exchangelabs.com>
Subject: [PATCH] USB / dwc3: Fix a checkpatch warning in core.c
From:   Kushagra Verma <kushagra765@outlook.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 11 May 2022 21:19:36 +0530
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Content-Transfer-Encoding: 7bit
X-TMN:  [bO1J4nWXV10J2F/almmfDbJNSQnsHed1pIFfBrWrkf+RgGczJSyv75V3hH/qku6uQE76r/Q3I8Q=]
X-ClientProxiedBy: PN0PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::11) To TYZPR01MB3935.apcprd01.prod.exchangelabs.com
 (2603:1096:400:8::7)
X-Microsoft-Original-Message-ID: <aadf3919413d4272fb1a2a90a37b35da304c789c.camel@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 110f4998-3d1e-4993-a5dc-08da3365ddfd
X-MS-TrafficTypeDiagnostic: TY2PR0101MB3358:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kfV7ttAWV56exuN52f/+pxowdSB/gpuVOLhDrG/DaA9QnehNH5y/RSfj9XsNSx/QcQPDY47EGYZ101WPDzkDNx+AMS4IUDo/ZHNbEIx7wJswSWhMye9+xL86sCtqe4w5XLOux8afKRzw3GWSY2kv8r1uAtoOq+3OAGvq7zPlSPolz6lSj3GV8zCct6sWulqVs0VoFhD1f+LEqVe6/FeVBDXDuNtm1zM/VgtABtJPs+Bl10hPCqEnbehFReG/JSir1G2Wbgl1dfoZF6Y/QwyLO+a4P0c713aGxN5w98iA2clHBVUdHBualtn8U72yklV9YYkgYoiBx/soibuINF69RFLbD97UKxQWhNBL71gtA8WR+klMrccprt8yAbXu3zOj3OFG0V1PMXPm0RRh8ceulKJw6+nXsOuJLyfgoFsbjdNZlGRnWPmXCYVj2trcWNkhkSC2YfVhVd5i73fm/NDgWs0GDRkS1Oih6uxDREf6CRefnvHCPzplpcACJqWS5LIto36tvXEYSGUK8d+nGOvDK3b/UgbHAfVo+4G56eRzJeiu8Q0SHV6bXyEQiFXgzbQ0xMhnydk3yimxzm/41rMVMB9mvA/Rx6bWaQhDtzSsoJLIQiGeU7boCtEUorqmwtvs
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c01RY2g4T01GOXY2ODVwSEU5WVVicXVBU3d1RkUwMTdyMVFDKzZwRVNLd0tI?=
 =?utf-8?B?eWFJbzNRMzgvTUdDdXlRamNTRzhPeVBOb0QzdTBxNEFPSTBGMkNySXVLTjJ1?=
 =?utf-8?B?QVA4VFhFZVpDWmtDMW9ieCt4NEdhb1d4aHV1ZVVWWW5zQmlSZnp4VU1DMUZR?=
 =?utf-8?B?WmF6Mjg5MDhMU2JwbGJHaFI3clBUam9VTnFXQ3g4TUdYUVFSVTFhL1ozWUNo?=
 =?utf-8?B?UTdpYmZDMUhOYVBzQndZdzVNQmJtTzZmeEcvN2ovbUlOTHNSQWN2aHZGVklF?=
 =?utf-8?B?MHN1bGpITW9KSUtqNFlWdnV1MjI2WFpySk01eFIrZm9NSDdNTG9pY1d6MWYz?=
 =?utf-8?B?RnVjcmFDaHE1L1NOY0pGRmtqeGVITHY3YnFhRzdxUWFNUU5yS1NNWFFmc3Zw?=
 =?utf-8?B?VUY1ZFBBdFN3WkUwQmNGT1RJM3Z5RWR3enhlaU93eFpWOTRrTEsrOVAwc0dz?=
 =?utf-8?B?bnhXdjZkL21UM2s5ZnFxWnVnZjVaOUtRdzQrejF2bUt5QnllZzIyVy9jWDRq?=
 =?utf-8?B?ZGEyOVM1Qno4SWFJUW1ZODRBeGJTRGhhZFZxSFljVU43dVFSeE5DaW5RaEJx?=
 =?utf-8?B?Q2VkYURBcnI5bHlFUkRiaE5XSkpSZGZ3aVlUWFVhM3pKY2NjM3BsTlJRRTJN?=
 =?utf-8?B?UlNjaHo3MWxsdkY5MXl5dGRKVWh0Qm9CSGNvUFVPUjEydVpOMnNORklTQ0Rx?=
 =?utf-8?B?SXRtRGFHT3RMcnMrNlpOaE1NMnZZd2VxaVlkdk5TdWlaTkFqZFBBU2FXQmVv?=
 =?utf-8?B?NWRFT0p0ckZkMC9NZzR5eTA5bGZFVHRhYk1IejNxa1NtRCtWS3pRNmtRRzFy?=
 =?utf-8?B?T0d6cHpjYWNnWGJZa1g5dGdsaXFHUlJyekw2MEUzVG51OThSRzlMM2dLTFQ4?=
 =?utf-8?B?NWlvM3Z2UnYzRXlzL3dYdWZVSFJZWnBta2FSNFZ3OFhqcEdaYVM1bFMvSkgw?=
 =?utf-8?B?OUp6NGtiTCtqQ1FRRkhlTXdjVlBWZ3RPK1B3ZmxTZ0ZYSWZOeEVLbWJqSC9P?=
 =?utf-8?B?bGJudlV6WmZkLzJmaEFtWUg3bTJHelRjRzI5Y3lZaG5tUXd4K0hIMDZHS3E2?=
 =?utf-8?B?Q0dJcVdJMkthV0Y5UDlQalMvNHVjSW5KS0JrbVZWK2kxcjdyYkovVXhRZ1c2?=
 =?utf-8?B?Wk5xZ0Q0Y0NQSCsvc1duTTBHcVZxZ0pzdGRHcElNNHBwSm4wRW5oUHQ2SXQz?=
 =?utf-8?B?elBWSWx4RWQvUksvOUM2MDZBRXpnY2k5U21ONDh1QXpCZW0xOGRRNktRYU8r?=
 =?utf-8?B?TzJpSFZCbUpsSzQ0THFoRktQT0tvKythNytzVFhleXI4OEZrQTE5ZUdYcDNa?=
 =?utf-8?B?UjNKZzYzMUF2T1RHcG9uQUxWalpraXlKalhhMytCc0V0bSt3Vmd3VldVQUIw?=
 =?utf-8?B?VEdRbExieVFGaFN6eGFvQ1pJL2QwSkZMN1ZuUTUzelN1dnpSZ2JtTFJoMUp1?=
 =?utf-8?B?Um1BNkJjR2JYajBsc2pQOExibnNRV01aZFNWb1VRYnVUYXd1MnNaSXpnQUpD?=
 =?utf-8?B?R3VZUDFyYk1hcklTZkJYUTM4Y0F4Q0xYS0MrWlVxV2I1alFZdGQ0NUJMVjRM?=
 =?utf-8?B?NVZETGJvRFFsS1dTOTd1SVVTbzhpMDVvaytqVmE2a1JPZ3Z4MXU2NlkxSWJQ?=
 =?utf-8?B?alVGMWFYSHNqVHRkbUwwSWtyck9lb1Juc1YvZ3hiZUhuQi9Lc3J6S0RQMWhT?=
 =?utf-8?B?WUR2Q0VMcEhMM2dycE1RMi9rTm1vaTJBNHJGV3h5RGwvNWpyOU92dklzNS9L?=
 =?utf-8?B?NFN4MkxLZWh0R0VCSnVUV2sxSVZubDZDQi9pWlFpcE9UYk10T0JoaDY3a1RT?=
 =?utf-8?B?c3RISzg2QzRwL05jb3RMT0Z0U0xycDM5OWhOblA2aEdIQTBKR3psUkhyRFoz?=
 =?utf-8?B?MXVvTXhKc3JycnB0L1NIWXhkTmhaaVhFeHRxbDlzWTlDb0dWU2lHTk9mY1lZ?=
 =?utf-8?B?N2MvTVo1czZmSGtFUUpnV3RibnFEYkI3cVV6dGNjZkU4QXlrQ0dmUEhqenVV?=
 =?utf-8?B?KzUxK2hYS21nZnB1THJqc05rS2I0N3BBN2g2MkhFdVRlcHpabkNGUjlnUmxU?=
 =?utf-8?Q?XeY3u6?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 110f4998-3d1e-4993-a5dc-08da3365ddfd
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB3935.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 15:49:43.8727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR0101MB3358
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch.pl warning in core.c:
    WARNING: braces {} are not necessary for any arm of this statement

Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
---
 drivers/usb/dwc3/core.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 7d023130e145..c78205c5e19f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1266,40 +1266,36 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 
 	if (IS_ERR(dwc->usb2_phy)) {
 		ret = PTR_ERR(dwc->usb2_phy);
-		if (ret == -ENXIO || ret == -ENODEV) {
+		if (ret == -ENXIO || ret == -ENODEV)
 			dwc->usb2_phy = NULL;
-		} else {
+		else
 			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
-		}
 	}
 
 	if (IS_ERR(dwc->usb3_phy)) {
 		ret = PTR_ERR(dwc->usb3_phy);
-		if (ret == -ENXIO || ret == -ENODEV) {
+		if (ret == -ENXIO || ret == -ENODEV)
 			dwc->usb3_phy = NULL;
-		} else {
+		else
 			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
-		}
 	}
 
 	dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
 	if (IS_ERR(dwc->usb2_generic_phy)) {
 		ret = PTR_ERR(dwc->usb2_generic_phy);
-		if (ret == -ENOSYS || ret == -ENODEV) {
+		if (ret == -ENOSYS || ret == -ENODEV)
 			dwc->usb2_generic_phy = NULL;
-		} else {
+		else
 			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
-		}
 	}
 
 	dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
 	if (IS_ERR(dwc->usb3_generic_phy)) {
 		ret = PTR_ERR(dwc->usb3_generic_phy);
-		if (ret == -ENOSYS || ret == -ENODEV) {
+		if (ret == -ENOSYS || ret == -ENODEV)
 			dwc->usb3_generic_phy = NULL;
-		} else {
+		else
 			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
-		}
 	}
 
 	return 0;
-- 
2.35.1



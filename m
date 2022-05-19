Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABCA52D743
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240727AbiESPS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240710AbiESPSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:18:47 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2104.outbound.protection.outlook.com [40.92.52.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337C6606ED;
        Thu, 19 May 2022 08:18:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGJEE7LpyMipujzly/QstNLjs0ytWUf4SPzhXbs2ZplmOpx7xhMpzQwMf/0ESmKYA2BM5yipJHJKLsxyp4thhsYTFNQqbE7NWyl8RvmbBofxjOxiqoPxVaLu3IFzkrFSAHhvD4aM1A4jjTlnBdFduVEj68pR3FMoDbiSkIxwmzjk98wSTz1BqJrPy9AswMfi4j+AcmndSBMwR6IXcvSfQvgTopfkBeC1BqMO+pkBIh38QhjlFFhzEfHB0rS/dtRsKVwUpoA+ynyEg/H9c8p3fxWB0KGH8HbyVD7SWs0clA3YjqKFdw5nHmynkj0LtdKgURNFSTXp9AJlXiPCKKO3Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJsr9s9ygFHwurQTpwiHtlQUvGtPwEegyIHuxjDfnKU=;
 b=lzXwMmLX153J1sakjqcvEJBqEQ4Yv+HRCsgS1x0BAxy+L3zm7RkZLrHIK3A59ICsjJnnKMxjgUCP03LdH/EBLo46Owxk6meHSmw/dUZvi5ypaaVZZHh90m1SMpQ5CFtb90lm64B9VKCzyjKz9Mp9BO5ZeK5hTMLuqPloiWUdxU/L7kTObsBxFxB9huuqR/xU3aUaua/5JhJAd3Jo0Aam33x/8/vdRUJrchiXy4M5tR+R0RPAagJDlXr/YHYr8iHPnHoLLEOS/0CR2DOlyPIajoDrKaUem8q4HHReCqn+MmToQtmwdrKdNi0xYnIcRpyaH8qmfqpZnjQbzU0c3ZKYqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJsr9s9ygFHwurQTpwiHtlQUvGtPwEegyIHuxjDfnKU=;
 b=odXaEf1SEIQoWCF0vrb0cwt6XeYdlYk3WHfR79EndrhOOakEwrXApsW9dKALp+QpDPH3CAapM4Hj9OKa8+FD1B3LqzXezrhBj2M4AMGZ92DgZV6oLcBf9fhLg2WOIWlkNCoeH9di4CI/VOVPpHj6VZp7kXIPV8dSfkdA3pxSiHIaO+/RVkgtuU5vAkkkKBqDOBAfHxOVjDzqUWqKdrywDmpMgSaWPxTA3FaQ5UxFzXBhGsHbTLrUkyeVP3WVAF/RMzOlTO2183JJpKVkFfjX0pQf3yUmxcIGmGXBw2G4lTGN9ig6BtDEYFTtOVUgIi7RUvCJCK2Yv01GwdrZDIEzUA==
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22) by PSBPR01MB3733.apcprd01.prod.exchangelabs.com
 (2603:1096:301:3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Thu, 19 May
 2022 15:18:42 +0000
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c]) by HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c%5]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 15:18:42 +0000
Message-ID: <HK0PR01MB280164D908E67763875BCE66F8D09@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
Subject: [PATCH 1/3] USB / dwc3: Fix bare use of unsigned warning
From:   Kushagra Verma <kushagra765@outlook.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 19 May 2022 20:48:36 +0530
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 
X-TMN:  [TFffkNu5+70/WrB6DwA3rfORn3cK5k8Jitrc0ElsNAOLyzohIsyTiiolJmLPE1SMxGoQ2bP3Ddc=]
X-ClientProxiedBy: BM1PR01CA0149.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::19) To HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22)
X-Microsoft-Original-Message-ID: <d8646700d9026456971556487bfc7c6dfe90da77.camel@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7aea4d0d-a592-4069-8f29-08da39aadbcf
X-MS-TrafficTypeDiagnostic: PSBPR01MB3733:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xhqZLtjpo3LgwVq6OMV9aa0zP1e8QCBijHY/DqiO5Ew1sPHiiakOSaT1K7iOSzj2f9GNnK4OTVrqROe3rx5MS6E+5oVV/upwaWIBo5bdCE0mahAeap6LEz/zC3PS1FAelTiOvnnID5ecYQP8uiuMTlBMh9fp8yRwbfr+L10vjteWwALBf+8jvFNreztyIxGQ7a8pkQ/yRyspP6xuyyBRaOCWlsSUNCtYZCBkoOj4jx4tHjvTpNbzrAV2EHypnsTcMYd0evQ0IKr66COt9bkvfcPx5LPGv9AM5WPyi1QsTOmxNwnM7PAkD5r+cpv+rAAofVHpOUnLzgJGjC3zF6RLisexDFEUs9O/tjEAjsfWNYi4FGieQjjI8WPn2i47i+GOXVZSPNupsDcaHabN+0jdDXIq2SIKSCpf7V1jtmJg6b+9bcrFfy+glmO7NmEfhJmvwng1Bl96GzVlrWGKpC+BNGi+NZu6BkCcs1BlSvjkefQLs4M0tRTd5gg3WqEd/2HnpJYd7GKsou+fEn0ExbCzqlfFcLIqjkWDZ5Z17ep8WfBzRJC7VECRDo9NBaT2G+aMBxy6Td4V450nN5BBhPunuA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVArR3ZWdnRLSTRySzZQekg4UitXWDVaTWJySXJvZGVvRzR2UzF4RVBORmR6?=
 =?utf-8?B?U0ZuQXY0MC9maEJTSDdzbUJzRVBzb1FNcW5RTW51M1hxK1FaeFJGYktqL1Ns?=
 =?utf-8?B?WURGQ2RiR2tWMlNFT3g5VG5JU2cxelhURmNhMi8wMU1ua3Z4THNxUEg4T1NX?=
 =?utf-8?B?ZUdhQzgxMjN2Ni9BcENKTWo0c3RiV3VKZXYyeTdVNk9FdUFmU2luS2RLN0lF?=
 =?utf-8?B?eVZybVpsRGcxTC8vUWQybGtWUmFaRDZERzU3dk5tc1hzRGpUMzBuNjczVVFR?=
 =?utf-8?B?SlBBa2l5ZUMyQ3VVbGVDdUZqc1NVS29FYldRNVVOZ09xdU1adGpsTjloaFJn?=
 =?utf-8?B?QkpteXptdUZtM3hIQ0FyL0FtTTlnejF5RGpsN3JxRDFLMGZMejFPSFoyQzZL?=
 =?utf-8?B?TG9udWwyeU5OQTVDRGhzN1JScHdJNVphMHpmdFA2RUI3WEthOHdVSVpZSE8r?=
 =?utf-8?B?bEh6bXl0TTFaTmVVMDF5d011cGJZVXFhcGFCRzR4VDRPdUI1ZGd2UWJUczZz?=
 =?utf-8?B?Y0M1NVRaQmJ0WkRpQVFUVzk2bHg4NHJXbE5jTDdLbndEZE0vREZvdWI1TUUr?=
 =?utf-8?B?eGlMUEYxQk03RGlMdUZOZlNCTUNTUUZKVzR3VnJiVVVnU1Z4MG1wOEttTmNv?=
 =?utf-8?B?SUo3Um5YNSt4eFZkSnNKSmV1VVZiMmEzSmxkNnRrRmRBMHltNXJIc1lKd3hB?=
 =?utf-8?B?YUtWcFNJNjBsR3hqSityeWliL2ZRb0I3ZmxqOXhwaUhsWmwyLy84TkUvY0Nn?=
 =?utf-8?B?UjJJSytlQ0NyWWIyNjUza3RqRXdoQjhLOFVWdXNxQWVVQUY4RW9HdjFhdHhw?=
 =?utf-8?B?Nm9rbFlLenYvekgwSFArb29seFQ5MTIvUTlZckNSUmc2azlRWWFlYnpPbnFD?=
 =?utf-8?B?NkF3Y1RMYXBXblVmVVFpek5lVXA3c2tXN0duZWZqNWplaGxoa3FqSUpkVCtl?=
 =?utf-8?B?UHFHZGtoNDVIamdwSklyeEs5RU5mUmlESjJmT00rY1I2Ty9xdTJ2QmdTVGt2?=
 =?utf-8?B?R01hNXhqTGQ5TnYySW9CYy9PQS91Q2RBRkRXa0tCbWJQSk13RW9GWm9FdEtX?=
 =?utf-8?B?ZU03UEtCK3BVYmtYb1FhRE5qOElxNjJLa1Z5T1RLZkFucElCUGM3dXJJQ25q?=
 =?utf-8?B?bVRRRjY0aGVtZFE5Z2tFaU05YnhhZ3pjYUtIT3o0T2J3Q2h1aWkrMGNTWmZX?=
 =?utf-8?B?c2ViNmg2K3U3MnBpcjcxbGhIY25tWmpFcGdQNFBaMkFPZnJ2djBtcjZpMHk1?=
 =?utf-8?B?NmVnUE9SN094ZkxxNVVxd3BuVnBPL3JSeG9xQWc3SGpwSzJrb2pEbi95NnpR?=
 =?utf-8?B?aTdyQzFjZFFob3dPTHcwMitsV2dGdTV3NC9ZUzUrZG53dTI5S0ptSWlXSWN2?=
 =?utf-8?B?dmcwdi9FVWlrZ2V4SGc5VjVmejV3UEZqdlFsbWdVWkl2RTA3WWs5dmNnMTlv?=
 =?utf-8?B?czhvSCszMEFQckxuazBQeml2Yk5tYTl0YlFWVHI2aUk0TDZzZUdPTWxCdnhD?=
 =?utf-8?B?eGFXbGo1K2p4emFLTWsrZlB6aVBqcENDalJoc1FFbWlITjZnWlpDTFNlT3pF?=
 =?utf-8?B?NlR3eHNmSVFMMCtxc1JhaTBIcWxNYkJwV3ozN25tNityNER5S3FyZ2JQVkNG?=
 =?utf-8?B?RTVrbVBxcTRHV3QrV2w2YitBZ0VYSUs1SDl3VXVINTV5RHNXbjRWVTJKOThp?=
 =?utf-8?B?MmZvN0hzTzlub0N1V2NJaEx6b0trV1d5SGlNRW5kRkFRTzQvd282R2FlNVNu?=
 =?utf-8?B?TTRmYjlTV3JHMkRLMGdoYkphUTV2a3AreFYvN3BtSTBIaFdqSVpMM2x2bUp3?=
 =?utf-8?B?K3V4dkcyYy82U0Q4ejFmTHJRWncvejlnT0VMem9sdVQ2ckpkbmRFbHJ6UXJB?=
 =?utf-8?B?eG1pSThXbmF1Qy96Mk5aOG1oV0hFVm52bTJNWERyTmJZSlRETHRzaGswZlZV?=
 =?utf-8?B?VjVIcGlCTStrRjdKMzlqVTlVaEsxRXd1eHFBSjg3enFpcG5aV1NobktyTUpx?=
 =?utf-8?B?Y2VGN0dKMTgxeXE3U0VQaWlGaHYvUU01NmpsUHlLdER4NVhNY2dUK1FnMFI2?=
 =?utf-8?Q?OqxL/v?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aea4d0d-a592-4069-8f29-08da39aadbcf
X-MS-Exchange-CrossTenant-AuthSource: HK0PR01MB2801.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 15:18:42.3414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSBPR01MB3733
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the bare use of unsigned warning from checkpatch.pl in
core.c by changing unsigned to unsigned int.

Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
---
 drivers/usb/dwc3/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 3c1a877d5183..d9713416a419 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -425,7 +425,7 @@ static void dwc3_free_one_event_buffer(struct dwc3 *dwc=
,
  * otherwise ERR_PTR(errno).
  */
 static struct dwc3_event_buffer *dwc3_alloc_one_event_buffer(struct dwc3 *=
dwc,
-		unsigned length)
+		unsigned int length)
 {
 	struct dwc3_event_buffer	*evt;
=20
@@ -468,7 +468,7 @@ static void dwc3_free_event_buffers(struct dwc3 *dwc)
  * Returns 0 on success otherwise negative errno. In the error case, dwc
  * may contain some buffers allocated but not all which were requested.
  */
-static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned length)
+static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned int length)
 {
 	struct dwc3_event_buffer *evt;
=20
--=20
2.36.1



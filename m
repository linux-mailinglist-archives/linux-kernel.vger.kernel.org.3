Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB4D572CA7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbiGMEfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiGMEfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:35:39 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2011.outbound.protection.outlook.com [40.92.19.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A28AC444D;
        Tue, 12 Jul 2022 21:35:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Os5v8jzSKTe+m4D1GbfIXxaG8XbCflxTR/xIV+lxwfuqmb9Q3XlMrLqMPJLqEwP7KwaQ7U62I3n4V4IIUYMUDyBT6OJnr5QpbvHWQ7Wbi8gF7rJqu4T6C6pnEuuoASlaOSVJUqPUsJex252KE5fZ6VXPEQ9+95ei/EM/1Ju2os2UClfNLapeuRBNI4owRb6WEFZ5+z6l4rGApl4l8fT6njRGG11Yx3NofkAm2ARqjMA1mLK00f4fHemjxkAPj7exaDATijEGNJ3b+LrXECRU2ZDMpK71FRY1NOMXI4iqrmw+/EDIuRx3cgxUl2U0VvXaGb5za/kbcYEvvzypksiWBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXJFM4ijzj/+JMc4a9SojL4x1PCVIVCFObGWDp0G1bk=;
 b=H08vqa4GSqNb1mW094DaytiwIoflQC8cpNDJrNKgMGG83Bv2JUX/knFaFhAEEDOGyxtcbpb6xzXfbFDtiaZ0fzlznP+LHOL/3DfU/XBtGfoL6rDtqO+magl3hcQjNQPO6tISzDwf1GLEIYmaHUUfytrH6tkMopzQk+ZflUchc30WYIrKvg2lNZvoIMyXUEotJ6uvYmll+OFKWP/dVMYctSMPIA6PBCc+9Co4Kz7WkTOp+48T3uJcoIcy391VobcOIuUsQ/+oRuN7njsxwuxWnRWi0Qc+GnK7IDg/Ia72i0NGWxhvwgx4BNSFa48u3MN+eiEPC6Ac+KUgVGBqZ5+w5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BY5PR02MB7009.namprd02.prod.outlook.com (2603:10b6:a03:236::13)
 by CH2PR02MB6101.namprd02.prod.outlook.com (2603:10b6:610:b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Wed, 13 Jul
 2022 04:35:36 +0000
Received: from BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180]) by BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 04:35:36 +0000
Message-ID: <BY5PR02MB700920503721C0C490BDAE2FD9899@BY5PR02MB7009.namprd02.prod.outlook.com>
Date:   Wed, 13 Jul 2022 10:05:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.1
Subject: Re: [PATCH 0/5] Add support for Xiaomi Poco F1 EBBG variant
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <MN2PR02MB702415D7BF12B7B7A41B2D38D9829@MN2PR02MB7024.namprd02.prod.outlook.com>
 <b1829902-c271-a677-f423-99dbc85cba89@linaro.org>
From:   Joel Selvaraj <jo@jsfamily.in>
In-Reply-To: <b1829902-c271-a677-f423-99dbc85cba89@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [crJma6yO/0pKuP9j1J+wSu4LpbpfNtm3ylj5Bl6OlfipFi7aIx1BLCjrxrulQpUy]
X-ClientProxiedBy: PN2PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::9) To BY5PR02MB7009.namprd02.prod.outlook.com
 (2603:10b6:a03:236::13)
X-Microsoft-Original-Message-ID: <87ff8464-8776-baf9-508e-d14661919b82@jsfamily.in>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faed5a97-3c2b-42d3-390e-08da6489218a
X-MS-TrafficTypeDiagnostic: CH2PR02MB6101:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3f5pY+0cUxTI0QeaUOuHKhPSdG2tqxBYY4eYmFGwKenXWXteLRWSsmaP0gugYi6qVsCBWqs5z5g949HAj5xyltY4gpcALE0eE80AEutG+7s9VagP8I3Fi0Xvm71Yi1YJfhqpaMa1pC4H/8ReR+NZaYbw5zBGY8kIZo/Xl10HOXXDgRkZvv2r1BU5mfJX9G9ZBr6QJAbpAM0WxMOH/M9suYeMW/00tu0tbqE+qW/j2QUob7cOjGmyBIxTELM0XX/3nV/xoK5MctQa03MxkdplliGAAVBcLqF7sg2TA8x9tjbwE/s2EB3Dyrd3CX8qvfg/iffUH5OOE7bqpP3d/QqxLjFl3PX0kU548pESH1xpcfEo3+3Aa0pg5TM/dQhI6Fc7Rq+5DhGYqPqHKxOkvP4gpyzZ7V5oMWw2jS5t5IEDgmbFSTyRa+d22tOlSjF2X42O1uMzMGI17Qg6eHqNnZAoBQJ+asXCSysHld2YiXyMpt1PupI8vJn0F0t2ec569ip/fSfOSOmrEa4HmAvdD0sEQAwiCEsLDZz5Ot38VE8IDI1EnpTUEvZfHpEOM5kZutuvNQMWhq5pK3xZ4Ont2AwPSW7tzee+pNjznjOURe+kY4iFXydr3HHsdyD9B63nDFWgEqZz/fybVXHn7qNwtzAIXMQP2fZS7gFsTivC4W50l+vJxvHN4ezzkQutz1mWHDOJJ7TrJAc2xmHVJwKZscPFGxEmhZCbDOe5Jt7jC9lSM3g=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REtyb091SFVvR1NSQ1B4cUpzWTBHWHhVVTllVUVOK1ZjekR3WGVyenpTd3FV?=
 =?utf-8?B?V1lVSU9McG5NQTRjNVlFZVVCVFFhY1laajVaSysrN2o1YXNmQXBqMUtCNnFo?=
 =?utf-8?B?SnlvSXpqd21HL2FlVCtpejNlU01xTE9lbk1rblFMRCs4aXBZa2RjN3ZKVHlH?=
 =?utf-8?B?dngwTGt1ZmtMcWVQNnNWUmZCc3BWNldReVJCbmJsRDZUcGVRZ2dmc1l2Unkr?=
 =?utf-8?B?ZzBHekFaSVlFLzVCRjI3ek9PTi9wVlp4bWcxNjRjbU5tNzVOa1R3ZStHZXpB?=
 =?utf-8?B?MUM0OVl5Y2pySXhDTmtST0FRZUh2ZXZidzZCcXlhSmF6cHBrMGY5YmZtZjZX?=
 =?utf-8?B?U2xjLzY0aTRGUXJDYTU3TWJUNklObkYyck9FNml0NjcrL2I5VHA3a3lIMUdV?=
 =?utf-8?B?ZGZ5SEU4d1g3dEtqVGtGN3pBdGFiRG9EcjcwVlRKbXRRQktLV3c2a3pYanMx?=
 =?utf-8?B?cVI1bUNVK001cE55VDRFODBtQVpwUXFWUTJFUGpTOTRDSTFIWmc3VWJtR3dH?=
 =?utf-8?B?eU9lMkJTUGtFcFZBWnVqZVg2Yk9ncnhKMUdBTnA4TFJHYkFCWjYvU2ZrbWhw?=
 =?utf-8?B?MGtIdGdNandUWmlZd1NiZkZ5RGRacEhwaDhEc0VCMWFWdWUvd3FqajZjdFdI?=
 =?utf-8?B?RlhrbG11Ui9Nb1JMRnhYNElhRHNJT21ESEx0TmtlcFFqTVdTTnVUbnBXdElV?=
 =?utf-8?B?ekF4RmtMYjlHQ1UyYkVwRy91bHBiNFEzK1VaVTE5VGJhditIcGFwNTJQd3Vh?=
 =?utf-8?B?QUdpUWdGcnhwMG05TkZWb3VOWUhZM0lSZWFqQzcxaXA2enZjRkZVSks4MFBM?=
 =?utf-8?B?TlgvVWEzcnJ0MU5nVkxPelBKdnFScnB3Q3QvWGFla1A2ODZlR3VydkdEc1I0?=
 =?utf-8?B?emFMMmd0eFU2d2ZYaXo2UkdNemQ5eFJoMFAvOU4zS2dyeWJVc05qdENlM0lk?=
 =?utf-8?B?RFFNZy8vaE5JVmwvdlJEL1FDRFJvOFlXdmVjdzNIYkRzZTBpZnRscGhqclhz?=
 =?utf-8?B?NGs2KzIxamNBVFRHTzVURVp2bTdBL21WaUZrcEVGQ2RIdnRDOGRVZHNuM0lU?=
 =?utf-8?B?WERYUXhhSWJRR1c0SWJrZzlQUWxPUTJzWmFtMjZISWRncDhLUFVZNkw0cXRD?=
 =?utf-8?B?SWdXVFVMeGNXRkhQbGpLR3ZFOHlUeU1rN0ljTEdFNFAvWGU1SHFJUWViVktk?=
 =?utf-8?B?dCtuTGN1SVBPRFZnZWtVd25mcVBZR1pVa1Y4NVFCQTgzQ2dCZHhXUlQrV09a?=
 =?utf-8?B?Nm1pYllJQmFibkZGTDlKYVMxM2o2QXVUSHM4bnBmbjZZQWlPd2RjWmRvZi9i?=
 =?utf-8?B?UGNOcWhyNmc1b2Y0bmgzWHdQaitvbStXQjIwZ2VQL2VOU05DVWxIUjVaVmpo?=
 =?utf-8?B?OUpyNWt0dUQvTk9XY20vd1o0cE00VUQzYnl6OHBzMndId3VlK3dIY3RGQjRQ?=
 =?utf-8?B?M0JnTVl4NXh3M0lCZEhuZGt5dHg3OEhKSkRqY0tIY1Q4UnkvNzdsMDRvTXZl?=
 =?utf-8?B?RG9uZ3NieWVPdmZqS3NuQUVLSVlwWnl6ZVZsN2ZYMmdEckhDYWI5ZXRQeGty?=
 =?utf-8?B?SkJvQlhhTTY3WU01VTh1d051QStoZzRRaWU0RUk4U3lISXlMQTVDZk1sd1Jv?=
 =?utf-8?B?VXlhRWpkRTRQSmtCOEtJZkVyMHpmS0RrYkFWUlZIOHNFNVVHb1R3Nkw0SXh2?=
 =?utf-8?B?K3Rud212N3VXamFpeUJpM05USUpwaVBFN3E5cURVTklWYldZTTBIMXRBaGUy?=
 =?utf-8?Q?Pwv/BVBsCCdIiqtyd+engdywdABCdLwWAHkTW14?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-99c3d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: faed5a97-3c2b-42d3-390e-08da6489218a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB7009.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 04:35:36.5943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6101
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof Kozlowski

On 12/07/22 18:57, Krzysztof Kozlowski wrote:
> None of your patches reached recipients and mailing lists.

Thanks for letting me know. I didnt notice. It was shown in patchwork
website and I thought it reached the mailing list too. I have RESEND the
patches. This time, the cover letter (0/5) seems to be in a different
thread and the rest of the patches (1 to 5/5) seems to be in a different
thread. But all of them reached the mailing list though. I am not sure
what is causing the issue though. Can this accepted? or do I need to
resend them again?

> Best regards,
> Krzysztof

Best Regards,
Joel Selvaraj

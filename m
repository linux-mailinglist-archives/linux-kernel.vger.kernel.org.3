Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9635673B1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiGEQAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiGEQA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:00:28 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4BB1BE94;
        Tue,  5 Jul 2022 09:00:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+6ZFgz5nyZEOSnnssk6q1UE2IOVxH4KZM3SX8sKRmLY9cQ+y+Tv0Bz6fxIFV+2MN/jQyJU7aSdA4DCOr1lnPCCZawExJ8Y+c2zoojke+YkXFEIQBpMu7t0hH9M0khdfiwQajgIDLpIw0xYewkHvaGkePVmVsDASlbGv8D83v4TXWyndo1lNsB1Zzdpy3h89wPS2Gom7eYEZMkvEnst5ejAyA9LxqNdtbFLB1gn1MoELzNNVFIyOquQjqAjppRU6r8CMUbTOs7vVbsf1eWsINGszAlp8HmyXCPfauTBkJn7RH7E3FZ2IyS+/TkMv3P8TrOuuWkKWpMfma7bZCzshYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDnsUZT7ub2VybL+8YlH8T9dIBB7CK7H0fwqUbdBGDU=;
 b=g3NFUJ1sEbhWgEoCl3zFU10CojIdUNQiDsjaGYyrlJpxItUNS+0b0lRhukGkMpwfbRZpu477z9WwcbzMreIqaijxZWrpf2+hXhYnfgULyXI0xZeyWLscS5b5XjQl0CCjJRG9ZuOSs8R9daWZladtfvk7D1rubhw4GwDcgz5ehoTAGMRH4WiYByu0BMPmGmxmdyJyUmsVL+6OKCZH3RCxsNEvk23mbHH3yS1gC7Qb/HkJfaVl8J5vO+sriLKivfcIb3V/JkGnCp1434oSaaH6KieBtpT3wSa+0ngdGsfnYsM8ir8CaY/+nyo8TKCaMRvclOM5Bv19Cf13DBwFQv0raw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDnsUZT7ub2VybL+8YlH8T9dIBB7CK7H0fwqUbdBGDU=;
 b=JWU6fWES1LFcEgpEn6EfcOAKbbSTwdM1wgZbA38Bn7PIP3m1X4UcIP/ZhBisrzGqdlQKfdNEfsWcckQWrVZb+fQEH3q61MYeSzzyhC6EGxAPNyPXVoeEO4E6WZOJaAk32cGVV8i80/Zky5cijAa/fxZ7RELIIAbZ2v/N87PfJkc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by VI1PR04MB4784.eurprd04.prod.outlook.com (2603:10a6:803:53::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Tue, 5 Jul
 2022 16:00:22 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::cc58:11a8:839f:895f]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::cc58:11a8:839f:895f%7]) with mapi id 15.20.5395.017; Tue, 5 Jul 2022
 16:00:21 +0000
Message-ID: <edb677c6-adef-81c9-c334-3d0619298734@theobroma-systems.com>
Date:   Tue, 5 Jul 2022 18:00:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 1/4] media: dt-bindings: ov5675: document YAML binding
Content-Language: en-US
To:     Quentin Schulz <foss+kernel@0leil.net>
Cc:     shawnx.tu@intel.com, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20220608134420.1750530-1-foss+kernel@0leil.net>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220608134420.1750530-1-foss+kernel@0leil.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P194CA0068.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::45) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c258a06-be65-4850-6456-08da5e9f771f
X-MS-TrafficTypeDiagnostic: VI1PR04MB4784:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EbfaPkaqgPpiDbQSWPv1g1DyGef62DqqL0+Y1yyDfuXS4jtmToRhiJTj+dK+OsZ3CGKEDs3+xrgBZkcr6/QneQXqop5HllMwgTIc06v9CbEnl/J/eVrYifm1kRem/hkjCL0iS7huspf+kijBwrXYMi0U/KCpi9gFtubpx703dbCK6xyg+OLe0rw1hF4EH+coQp/7xZqEdwVViVG7NBUkga9i1Byzi5Wx4XONhiOPaCe2k+2B6YbheAZ1fzg9hyFOCEiWzXkgFWb/jolgRIarM8rDIg67n+5V+r0+a2dSAraSz//DyNfwHeBJRcyFZxV6MOgsq+D4Nrqst+n3mpPYgnyoCznCexe+ESF4eI/hfVXMA/13TOlbGde57J7KJbpYgrQKnFybWP//bCPrjCtjxsFxrm7ND0N/c8g/sIWoqEBY0QLAkOOc+/UZ0WwsT+KNYjRqf1H1psp00KN/A6IPC+AzXjALE4FT5HzPPQnIwD2cVFsI9fTgkpO7uifRqy/Afh8lKcO7hgfr+cYwlHwAQJkVu/HlDAgOG/cJA6USlEWlZqnQR7bCuWdKVhbrHoVQo+wWzKZoiN1pG48NRxNMdWykWG9Dbm5yf99npXk5NDKDeigJvbz11P78jdVJI9aV5YcN5/WvEYVR3EYXK6yBhSVW+9gq7j42kuXEmjo3pJdFu5P4hVRhTyQATktJbYb0YfwnYjw3XngZxWmXY8vzbZt9F3Xu1vVmdNEacl8MNGcmG760N/oc+M8JJ7kByAPRsqCvMGEg2GFR2I1MMZf8AUH/6xRor5oj6yVYG7zZv3WqT6VY5vC5fu325v1LflmP/TyRIeG1f1DMO+O2K/ACG6RL73/Qre0LIY+qB6t4nJqI8JSjfhxbgtvt5ZTxZirr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39840400004)(346002)(396003)(136003)(376002)(366004)(44832011)(8936002)(36756003)(5660300002)(2616005)(186003)(86362001)(83380400001)(478600001)(26005)(316002)(31686004)(6512007)(31696002)(966005)(6486002)(2906002)(41300700001)(8676002)(53546011)(66946007)(66556008)(66476007)(4326008)(38100700002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUR4N3l0QlpwSWhPcmhOSnR3SlA5Q0V2Z3pJZWZYK1cwMjdKTGtMNWNMb1R3?=
 =?utf-8?B?OEVEeVA3eGF6ZjRsdnkxcmJ3QTJ4NmZUVFprM0cxWExBbjBZVVBQZHZIK1Nm?=
 =?utf-8?B?eFplZzVWeHdWVjhUMWRxZ0xBZVpTbThpdktjTzJVQktMRHR5VlZIZkhzZ0NW?=
 =?utf-8?B?bytrWVIzL2E3dUVUVFhWM012eXBxNE1lZitjT2h5bmdvQVBkYnVtd3l0Q1dj?=
 =?utf-8?B?N2NkN0l5QTVNSlJYVTY2eG5RUkphZjNkN0FsVWtaQzhPRDlDNk5VbDBCdVFy?=
 =?utf-8?B?bGJxdEh0T1VtM3B3YXZSaytwL0hYejZzQUNLTzROMlJKeitrVkhPeHJDV1I3?=
 =?utf-8?B?c01OS0VzVnh4ZGt1WHRsWEFUdVFKcVhRWk1EQ0VWUnRjc2hXV0p1ZlF4L1ZR?=
 =?utf-8?B?clBiQ2J1aUlUN3BGYUJzRkdxbkZidm5BbW9jWk8wSXEyZW83TWZPeTRlRVdh?=
 =?utf-8?B?dlJMQnpMRzU1cFRrRGhCNnY4Q1ZKV0hOS3hNZlJGYjE5RGNDc09iNW9NYTFH?=
 =?utf-8?B?ck9YU1BSaDRTbEFnZldycmRwd1RwakcxZDQxaFJCbUhVT2M1T2c3SW9rU05a?=
 =?utf-8?B?RnBBbFpFVkZPZEJKNXhHMi9URy85WVNpSllVL25kTkJkNDBNZGMza3J4MFhq?=
 =?utf-8?B?TlpycDVnUXIxd2pDWkJiRVlyQ2xITFRobmRTQzg5bU1JTUVXYkhCTmVWTlFh?=
 =?utf-8?B?ZUk1NXlIRkNMcU90UktCZ3RJbHVTa2dzbkJZYmFNL3dPcUVRSmVoUkZZRXlM?=
 =?utf-8?B?VVFWdFV4ZG50dVBWTkFoQ3FGd3Z3dGxGakFMdFZvZ1crNTFxTzJjZEhHUU8y?=
 =?utf-8?B?YWd3Y3M5RUlaTmlkK243T1RmSlJPaitORVBRVXVEK3lmS0ErbHYxWDVHY1Vi?=
 =?utf-8?B?U1d4RDMzc2NDYUlMaUR3M3BZWldlVVFlMHhFV0tQZW0rWStEWXJQcW5iWWtS?=
 =?utf-8?B?alFvcmFSa0RuN2l6UzdIYldJUG0xUG1HOHViN0Y3NTRCb05UY1N2ek9LNmVx?=
 =?utf-8?B?TTdNNWcrODNDVjQ4aW9DNXpaa1pwLzZreG1CeTBPd2NNOU82NHVtdTZGSVB3?=
 =?utf-8?B?ZHlRL0xyVHJmOVAvOXFzMUxLLzFwckJOKzlqaGtFc0RmT3JpWmllTVlyL3Ev?=
 =?utf-8?B?TGJ1RmhQeE9HeGRsa05CcWtrRWM2TkdPTGozMWZiOWhueXR3eVZxa2U5OUtH?=
 =?utf-8?B?MDlVamxETnpvVCs4OWx3V2JSSWNNUE9FRVFIQ1hWeVU2VlhPWUk1SEpib0lV?=
 =?utf-8?B?UzA2MTRZZTY2cmpsdm1pNWh3V2tZVDR4aUVRSVkyRFQ5TTFQcjE4NmZybXRL?=
 =?utf-8?B?WUVKNmhyWVJmbmxnck52SXp6QmN1WFYrbGFPb0ljUVJHUlFXVkI2bDBmK3U1?=
 =?utf-8?B?LzdIZmN1M0gzMkRaRWRzZlMxRHJvZW1Ga3V5eG5VWUNsYTF2cXJlOC9JZ3lE?=
 =?utf-8?B?MkVnQW40L0xhYWw5WmxRajBPWjdENGIxYW5GUWlja01Xa1h4VW4yek9wYnox?=
 =?utf-8?B?b25ZMUE3WXNzT1R2UG9tVGI5MzhadWdjM25ncW5YWlZoNURGNlZQYUFkMmhm?=
 =?utf-8?B?V3lkbUpLYXlJUWpUMFJnODlURGFUdW1GdFV4SDJvYzU3aG9PRURmdzFiejZR?=
 =?utf-8?B?WU9JOHFqUjM3SHdmdlFXb3JwVE5rc3lyb1dJL0s0NmVqUnpxSTNKNHYvMlJr?=
 =?utf-8?B?VVo4NWVod1d2eFJkeVp6UHlXeFBJMktiejVOcXprTXdFa2FKZWFCSnFYQzI4?=
 =?utf-8?B?SGR0a3dDWDhUK0Zpek1Xa1BIcW5WcGM5TmNRVTBORGxzMTBGNUYvQlJic0Jx?=
 =?utf-8?B?T1MxeGtGL2oxekR5L0E1N2hKVUNWSjNHNXcwV08xWnlkV0E4SG8vaHByWFl2?=
 =?utf-8?B?SXl1MEtNdEZudTlsWTlPTXk1R2pydit4MnBCOG5TZWE4RXVNVFU2ckNzaGZr?=
 =?utf-8?B?YSt1WExRakExQzQxanR4Tm5rdEVHMENQb0JNRm95c2ErbWN4ODRCNWhWQVha?=
 =?utf-8?B?aGtrdkFSeW9DeVMxNW11akF2SGNRd0tkZ2hwQnd6dEJFRFJyV0p3Yk9MK2dX?=
 =?utf-8?B?UURoVEVPRk53c1U3dklDZ01tNWl5dW8rYmwwakhWU3ZYZ2FTcnV1OG1KSUpj?=
 =?utf-8?B?N3NUVFZEbjJFQXJKMlg3UXZPQ3dZZGx1REJLSjBZSCsxaWNpU0JpdXkvNHB6?=
 =?utf-8?Q?XsABLEhBqgngZLtxzRHfei4=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c258a06-be65-4850-6456-08da5e9f771f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 16:00:21.9109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMvTJjaDcdNFeaCR7r/HYgElIiDs1nm/maYb1mqGx9djnUASoXhZ4e5BUq6PvqQNpusUFz8zZtH/JkF7BV395iCSKXeEuTAWZH60M7vZY0cT5nM+Ek+zl6bw32hx8dmJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4784
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Any additional feedback to give on the series?

Thanks,
Quentin

On 6/8/22 15:44, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> This patch adds documentation of device tree in YAML schema for the
> OV5675 CMOS image sensor from Omnivision.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
> 
> v4:
>   - added Reviewed-by,
> 
> v3:
>   - removed clock-names,
>   - removed clock-frequency,
>   - added all-of of video-interface-devices schema,
>   - added clock frequency range in description,
>   - rephrased definition of supplies,
>   - fixed name of reset gpio,
>   - used schema ref for port and port->endpoint,
>   - removed mentions to driver,
>   - added HW data transfer speed limitation in comment for
>   link-frequencies,
>   - changed root additionalProperties to unevaluatedProperties to not
>   have to list all properties from video-interface-devices schema, such as
>   orientation or rotation,
>   - added maxItems to reset-gpios,
>   - updated example to use assigned-clocks and assigned-clock-rates
>   instead of clock-frequency and clock-names,
> 
> v2:
>   - fixed incorrect id,
>   - fixed device tree example by adding missing dt-bindings headers,
>   - fixed device tree example by using vcc_1v2 for dvdd supply, as requested
>   in datasheet,
> 
>   .../bindings/media/i2c/ovti,ov5675.yaml       | 123 ++++++++++++++++++
>   MAINTAINERS                                   |   1 +
>   2 files changed, 124 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5675.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5675.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5675.yaml
> new file mode 100644
> index 000000000000..f0a48707bed7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5675.yaml
> @@ -0,0 +1,123 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2022 Theobroma Systems Design und Consulting GmbH
> +%YAML 1.2
> +---
> +$id: https://urldefense.proofpoint.com/v2/url?u=http-3A__devicetree.org_schemas_media_i2c_ovti-2Cov5675.yaml-23&d=DwIDAg&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=hkLsYZWMEhpLI6ShhGo0x3Jiuqy6R6W720Ntjy_xiWib19fmlU43ao0fGq1ALlC0&s=dJP3Z1NZNxGh-udGBCMYQKpHV17u1R0DloWk1smrUPE&e=
> +$schema: https://urldefense.proofpoint.com/v2/url?u=http-3A__devicetree.org_meta-2Dschemas_core.yaml-23&d=DwIDAg&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=hkLsYZWMEhpLI6ShhGo0x3Jiuqy6R6W720Ntjy_xiWib19fmlU43ao0fGq1ALlC0&s=hJpvHfydAEL-abkbxj-ZSKxgR5wrNKozJb-oj-TaIfc&e=
> +
> +title: Omnivision OV5675 CMOS Sensor
> +
> +maintainers:
> +  - Quentin Schulz <quentin.schulz@theobroma-systems.com>
> +
> +allOf:
> +  - $ref: /schemas/media/video-interface-devices.yaml#
> +
> +description: |
> +  The Omnivision OV5675 is a high performance, 1/5-inch, 5 megapixel, CMOS
> +  image sensor that delivers 2592x1944 at 30fps. It provides full-frame,
> +  sub-sampled, and windowed 10-bit MIPI images in various formats via the
> +  Serial Camera Control Bus (SCCB) interface.
> +
> +  This chip is programmable through I2C and two-wire SCCB. The sensor output
> +  is available via CSI-2 serial data output (up to 2-lane).
> +
> +properties:
> +  compatible:
> +    const: ovti,ov5675
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      System input clock (aka XVCLK). From 6 to 27 MHz.
> +    maxItems: 1
> +
> +  dovdd-supply:
> +    description:
> +      Digital I/O voltage supply, 1.8 volts.
> +
> +  avdd-supply:
> +    description:
> +      Analog voltage supply, 2.8 volts.
> +
> +  dvdd-supply:
> +    description:
> +      Digital core voltage supply, 1.2 volts.
> +
> +  reset-gpios:
> +    description:
> +      The phandle and specifier for the GPIO that controls sensor reset.
> +      This corresponds to the hardware pin XSHUTDN which is physically
> +      active low.
> +    maxItems: 1
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    additionalProperties: false
> +
> +    properties:
> +      endpoint:
> +        $ref: /schemas/media/video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          data-lanes:
> +            minItems: 1
> +            maxItems: 2
> +
> +          # Supports max data transfer of 900 Mbps per lane
> +          link-frequencies: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - dovdd-supply
> +  - avdd-supply
> +  - dvdd-supply
> +  - port
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/px30-cru.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/pinctrl/rockchip.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ov5675: camera@36 {
> +            compatible = "ovti,ov5675";
> +            reg = <0x36>;
> +
> +            reset-gpios = <&gpio2 RK_PB1 GPIO_ACTIVE_LOW>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&cif_clkout_m0>;
> +
> +            clocks = <&cru SCLK_CIF_OUT>;
> +            assigned-clocks = <&cru SCLK_CIF_OUT>;
> +            assigned-clock-rates = <19200000>;
> +
> +            avdd-supply = <&vcc_1v8>;
> +            dvdd-supply = <&vcc_1v2>;
> +            dovdd-supply = <&vcc_2v8>;
> +
> +            rotation = <90>;
> +            orientation = <0>;
> +
> +            port {
> +                ucam_out: endpoint {
> +                    remote-endpoint = <&mipi_in_ucam>;
> +                    data-lanes = <1 2>;
> +                    link-frequencies = /bits/ 64 <450000000>;
> +                };
> +            };
> +        };
> +    };
> +...
> +
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a6d3bd9d2a8d..302983893831 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14703,6 +14703,7 @@ M:	Shawn Tu <shawnx.tu@intel.com>
>   L:	linux-media@vger.kernel.org
>   S:	Maintained
>   T:	git git://linuxtv.org/media_tree.git
> +F:	Documentation/devicetree/bindings/media/i2c/ovti,ov5675.yaml
>   F:	drivers/media/i2c/ov5675.c
>   
>   OMNIVISION OV5693 SENSOR DRIVER

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37C24C7193
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237866AbiB1QSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbiB1QSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:18:50 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2114.outbound.protection.outlook.com [40.107.255.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1BE527D4;
        Mon, 28 Feb 2022 08:18:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KR1sy6D0kCtL0YwOZKJwx3eD1MIRnnbhtq3KWJHq5USe/j3i0bS9RbLFh3OLERLfFskEu/tuOV5lk1Bj/gTIu1wLtHPvdqpKr5SCP23vqxp1ArFLNN+rEWyAAo5uonqXpEd7g/SxGdCdZJe+EE13xiaLtVRwP5Za6ErWXE1wkcz4ZVH+HoRh4sCuzFR5gftQlXoG+hLNx2A2tFuSGhfFEfTEX5ermty4rODzyezWUKnbSu10SR7N7q66VKduPWXkX9Ya8BGrIDvJV/zfuZtjJthyow5UtDisKpmqewnCJsSaThVKJpMDRUf3krRhI/wzF367C5pFTz6Xnuxl5SPNLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+8/H0NHpKlnvNtcJFhSQutO9WpQWQIbHpGgXWCCoJA=;
 b=NdA9krfGgiBaBidWfCGbrx6Lxhq25NvMI9MMGozOjSPsOv+kr9KLoL4RSF/izvHNUy8I2lVcEtQwkO1/gBpLpPvVCIbDN5D9g47WbjWkYMbTmktSxXO+8XP1ZCtslAbHLjA0U/7JmpZXWMbjQUBgysSN2llCFENXK3xDBJgIsGgWY8WZfrNZN3Zzxd0AwvyrZWkURCHJk9D1pZ/ZONdR7NQhRX61aZ4HSlOyJN+Z5E8DwZuMLU5G4BUXxcyAumt2xxKVO39X/IaE8iQEUmD+JxufQQLU/vlCTeilmrHEqLRJFgSTUBveifkaxsJv/E8LtZTyQ/Vtj80PJ4V4LX0CJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+8/H0NHpKlnvNtcJFhSQutO9WpQWQIbHpGgXWCCoJA=;
 b=2vcvmFsxq3mClS+cSqD4dFYr0Q7JMJUUSf9+JYqNaKNindHjjXFhVBOgyXQq3cP9X5UX+VcyB04kDPGAMPip0/nElkL+zQvny8cZuGKkWXPRJsva2Q4UyG1HWR4orCQAlMhNfSRKI0KVXzoYH+CWUaXrLDPmlobOw+K0cMlPLTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by SG2PR04MB5724.apcprd04.prod.outlook.com (2603:1096:4:1d4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 16:18:06 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab%3]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 16:18:05 +0000
Message-ID: <a8d4b7a4-2b2d-f724-2417-f8f14e388c98@quantatw.com>
Date:   Tue, 1 Mar 2022 00:18:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3 2/2] dt-bindings: hwmon: Add sample averaging
 properties for ADM1275
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220228103716.10774-1-potin.lai@quantatw.com>
 <20220228103716.10774-3-potin.lai@quantatw.com>
 <eb049c6f-f196-95de-265e-c3454fcb808a@roeck-us.net>
From:   POTIN LAI <potin.lai@quantatw.com>
In-Reply-To: <eb049c6f-f196-95de-265e-c3454fcb808a@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK0PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::15) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f554357b-ec1d-4ec9-323f-08d9fad5e68d
X-MS-TrafficTypeDiagnostic: SG2PR04MB5724:EE_
X-Microsoft-Antispam-PRVS: <SG2PR04MB5724BD3BFA606E78404ABE358E019@SG2PR04MB5724.apcprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z2oxBb1qUFvQZGzYo/yxF014cbTDT4FmvmfXnv1ojVxx8JLQf+DyOCJ96HAkohF3E1iSDsYnEyiJcprZ/KXVGRWr9OqqQ1chjF1TcS66QhqVziATp3w0U0yml7P/xoBfLW/oNYfPWl+SnYBP9yyRtMJGWKORF03ZzatyzRVDDQrOnIyfCbbwcUSvuvccpDhAU+8HVsYmXNZyRN/VMBq6xLqH8oVZYc4cXjFR6w7YHg871EGmxZQct6HLeC+HJbXVYd2Vi+OLcxfmPJKWl4lfjnJVEahpywbeUBmQZs+wykdYOq1tPYSOv0PEa/20ZgdsO8Gc/RBKujgY78hpb2m03xUJdkYDJ8FquDwb0jdMTyxhSFVCDgjcpCmXccSCA+g/0CawLhdo4dfX1ByGPdBiCMAA/4lIpGtUlVtTrGujBVchQj9H8f3f3gjp7gdeEGrB+bj405THui5mlcyk7UZOaD44zzvZCruCY3JrkLH+3DGbbM2Kb/4WLVlXDrYYCoRVEULzYCe7amsu+MkQkGryTiG/clKe7YJnoooRaQqvfa45Poo7bMjbJ6Hls5nNJ9w2hXiPPuKQ8+W8RLqNO8/eUJpucEP7yvXLV/TZBVEQuWOQS68w5jCUhUV2S7pOUVvvZb2PpJSFMkCWxN8p0f6lN4YR96OzHP1tFICG1mbdN64eW9K+9rB1XH51eqC+V4vHJB/YnJpwzgjz3xLomtvuvhhuijHB7XT13KPigkvhYvTZe+9J53IN7c5bWBxNewiJVWdR+2kpdf1csafcyBJ8OQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(508600001)(186003)(26005)(110136005)(83380400001)(36756003)(2616005)(6512007)(6506007)(316002)(31686004)(53546011)(52116002)(38100700002)(2906002)(38350700002)(5660300002)(86362001)(31696002)(66476007)(8936002)(8676002)(66556008)(4326008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE8wSGQzSjBSNzgwN2MzUndWd2ZRcmFwYjloRlVsTTliN2xkTE5xOVVlcTRM?=
 =?utf-8?B?b0lkajZQRmtvZi92VThDR1ZYNUEvaytsOWhEeWxERjQxNll5Q1ZnR21UNk9x?=
 =?utf-8?B?Q0VvSE41djRxd3dBalBnRUIvTC9aR1pFNEl0aWxtdUw0SHQ4Y1FSTWxaT1da?=
 =?utf-8?B?YWNrcThZOEJHVXpPbEY5UWVSNXBBTUwvNlZuNHJuU25ocGJDUTBudDZWUTNO?=
 =?utf-8?B?MU9jYlRHMXNXVFdhMURoVkF6Zlp1NTNkM2FHSGwxc240UDRQclVoWlJZMzhJ?=
 =?utf-8?B?empKK3hrOHBkQW9mcHViSFRqblZhcWJiWUZMZFdSTVYreFV4NktWbUFWeVRI?=
 =?utf-8?B?VUZnVG1qblZJS0l4cWhIL0s2eURDNzlhbkV1RkFhTXhhR2dnMGM1THhJYUhC?=
 =?utf-8?B?OEJsbXJoQ0dWMGlEWnZ4WUU5K1hLankzU3lNc09WN1JpYXNBMVR5VVRjVjVt?=
 =?utf-8?B?Mkx6ZnR4OUZOc1d3VVFMdHJPVHk0N21BK2J3UlFMOEc3ajlycHdnajlHTnUy?=
 =?utf-8?B?SDI2QzQ0Tnl6eUo0QVNwTHhlTEF6THpncWhiWkQ3bjJheHRORldiMFFTc0FZ?=
 =?utf-8?B?R2xoTVdTQ0FDNlBrS3YvVU13bGNBdUN4TXBNb2VGc1dyQ3hzdVdNRUloaFFq?=
 =?utf-8?B?ZWlkMFpDRUJ2a2lFV3U4RWtLelZkd0ZiRnJSSnFVVk1NOExjeEcxUVAwVUZY?=
 =?utf-8?B?WHZKayttOWFreXJJRzB0UDh5OTg5NEcydXhBWWl2alBXV3h2OHVSZmRKS3Zs?=
 =?utf-8?B?dUs1ZGh2RkxKUi84cnd1RDFoVFpraUZkVGQ1dDVBZ2M3NUtpWis4UVA3UnM5?=
 =?utf-8?B?TmFDVHQya0dVNkYyVDhnYkdXYUlWU1ROWTE4QTMyaWo4TUU5RnN4MVZmQkJa?=
 =?utf-8?B?WDNnemxhaElKZU0vc1h4U0RqT2ZucG1BTnJoRG8weFcvRlpMS280K2FxeG5t?=
 =?utf-8?B?N3ZMNzgzT2hPUUVYTFB4MU5jY3Z1Q3F1eG44bzMzYmhGNEViNXozeE1RNkZT?=
 =?utf-8?B?eUZqb1hGZlBMZVFaM1drby9BM2dZZGVCOVN4ZlpNZXZTRVh4NHNKaDZZdmht?=
 =?utf-8?B?SnpHWmw3OS9RUzY3aWdReUF4UllqaFVmWU04ck1LVEdXL1YyY0JucnROaTE4?=
 =?utf-8?B?YjRYd0NvYmZtQkpicnVkeTFscjluNmFldThPcERKM2xzeXJxMjFFTDdVSmtn?=
 =?utf-8?B?MGpnREF1eVF0dEtWYUJIVVZQT09FcWtnQzdDVEx4OFZuUFY5SlRNOSt3dW5n?=
 =?utf-8?B?a2tpMnVkSUpxUHB2allPeWxhNDhvVmcyb2hSSmpURHR2eWt0NUhXbTd4OG5K?=
 =?utf-8?B?UkQ1anlDdWFScmptV1ZGVkhaelpIdVlFbjZPMHdOVWxVenlwY1E2c1FibWFE?=
 =?utf-8?B?Q2lCK0o4Tm5COVZqb0JIYlI2MGFNOWlSQ3Jhb3dJaXRYREdPNEJCUkE0VXJq?=
 =?utf-8?B?VTMyME1vRzRBTkxlcUx5R1N6dEcxSkFkVGp4UEUxRW4yMUJOZkNaRUhWV2hM?=
 =?utf-8?B?bnNXT2g2bXFCM0V1bFBJeG96OVRyUnpXRDJGZEg1bVZuUzMwWlpVczRUREdr?=
 =?utf-8?B?RGZTRkcybUdTRUhyZyttbGxzakdkZzU5bGdsQkJnMWVpd2lnYmRVaTRzbXFr?=
 =?utf-8?B?T0ZWSXFRaEV3bzdoVlV4NE4wL0FZWVNjY3VSTnZUK0w4Z2YxNVNkZUNaK3RV?=
 =?utf-8?B?SVc2UlBGTDFJK0hlMjliMVRFeXNFTmpIOU1MV2pOK2hWUDFkSk9WWmZ3aEwz?=
 =?utf-8?B?L0lveStLd3dab3VieGpxdGhweVFZWEEyZUlNb0VIY3RZZ0dYcE4xb25RVXZm?=
 =?utf-8?B?YjNNd0Y2ZkJBc0FUbUNqTFRFK0xlVk4xTWlPandIKzdXdkoyUHFDRm9yMFA1?=
 =?utf-8?B?TTFCZzR1c2FBNkcvcFJiNnBVcUtla2tJQm9SRDd1K3QwUWpVdkswZUM4ZEJs?=
 =?utf-8?B?aXMrblFwTU91aTZuQzY1Mm5mVGk0cGNrKytpeDM2cGgzREI2Y0dzdUs1cFhQ?=
 =?utf-8?B?V3Y1RHV6aUIzNm9VOGJDSmZUSURoMVc3dnlrc2ZhYnVSVlAwRHdkTnlFNHBm?=
 =?utf-8?B?NXB1TE90MUFCK1BYektKcUFFS0NCcGUxZFl5SVBxTDJlWXZSTTVyZ24rL1Nt?=
 =?utf-8?B?dDVWRC9qUzlLS0EzZTdPcXpINmdTZURPSG4zOEZPazh2bVFJMHphaXp1TkQr?=
 =?utf-8?Q?C8stp9YlLRHMg9LYzaFjzxw=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f554357b-ec1d-4ec9-323f-08d9fad5e68d
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 16:18:05.3720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2QmrnE1FAsO8Hdg95BdRUp4DTzxNi9DclsPBYlNspCyqGT9g7lEit1ZkEkuQHM+nuDxd8Ph2mDUGd829DB73g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB5724
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Guenter Roeck 於 28/02/2022 10:54 pm 寫道:
> On 2/28/22 02:37, Potin Lai wrote:
>> Add documentation of new properties for sample averaging in PMON_CONFIG
>> register.
>>
>> New properties:
>> - adi,volt-curr-sample-average
>> - adi,power-sample-average
>>
>> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
>>
>> doc
>> ---
>>   .../bindings/hwmon/adi,adm1275.yaml           | 39 +++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>> index 223393d7cafd..bc4206b257a8 100644
>> --- a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>> +++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>> @@ -37,6 +37,43 @@ properties:
>>       description:
>>         Shunt resistor value in micro-Ohm.
>>   +  adi,volt-curr-sample-average:
>> +    description: |
>> +      Number of samples to be used to report voltage and current values.
>> +      If the configured value is not a power of 2, sample averaging number
>> +      will be configured with smaller and closest power of 2.
>> +
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 1
>> +    maximum: 128
>> +    default: 1
>> +
>> +  adi,power-sample-average:
>> +    description: |
>> +      Number of samples to be used to report power values.
>> +      If the configured value is not a power of 2, sample averaging number
>> +      will be configured with smaller and closest power of 2.
>> +
>
> Both properties should only accept 1, 2, 4, 8, 16, 32, 64, and 128.
>
> We accept non-exact numbers in sysfs attributes because we can not
> expect the end users to know permitted values, but devicetree authors
> should know what is acceptable. Valid values can be expressed here
> easily with something like
>     enum: [1, 2, 4, 8, 16, 32, 64, 128]
>
> This can also be easily tested in the code by ensuring that
> the devicetree property is in the range of 1..128 and has exactly
> one bit set, such as
>     if (!val || val > 128 || hweight32(val) != 1)
> or with something like
>     if (!val || val > 128 || BIT(__fls(val)) != val)
>
> Guenter
>
Got it, will make the property value only allowed with listed values, and add check in drive code.


Thanks,

Potin

>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 1
>> +    maximum: 128
>> +    default: 1
>> +
>> +if:
>> +  not:
>> +    properties:
>> +      compatible:
>> +        contains:
>> +          enum:
>> +          - adi,adm1272
>> +          - adi,adm1278
>> +          - adi,adm1293
>> +          - adi,adm1294
>> +then:
>> +  properties:
>> +    adi,power-sample-average:
>> +      description: This property is not allowed.
>> +
>>   required:
>>     - compatible
>>     - reg
>> @@ -53,5 +90,7 @@ examples:
>>               compatible = "adi,adm1272";
>>               reg = <0x10>;
>>               shunt-resistor-micro-ohms = <500>;
>> +            adi,volt-curr-sample-average = <128>;
>> +            adi,power-sample-average = <128>;
>>           };
>>       };
>

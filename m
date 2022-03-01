Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A13C4C8BDC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 13:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbiCAMnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 07:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiCAMn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:43:28 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300122.outbound.protection.outlook.com [40.107.130.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363A132ED6;
        Tue,  1 Mar 2022 04:42:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPBzsK7dt0jQSsnnRj7ci3TjPRfjk7En52+xt9neKJhVn1oCcQiMDjYIuc1fpC/6mTMx4NMHCSt6HIUEw4oLcCAm7sbyqVan/b+ptJovTYA1+yiJX+9bTLTPBr0WzyWXEYJOLe0tJLHN9xbm3E+uqGlTso666db8g9meyB/XY7NLOXLaPe3QmRsmU18p30CT/waMHVsZYbaAEd9Kf9eht3yPhh9IGCf4wvv/pWyAE7e8DVd/2xQcM4VPhmmvSI1ken7DiOLNCOra4sT870xsiqaavLn9BPDShzfZOkwvqdT5FJeCSwBvtqABWfeScfI2jG36FJFV4VYr6hXUbag7Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+icA7PhvM//zDaw4/TjZqIAUIagH3JKjLDXdWPvDKw=;
 b=Z+7rwRHszMPCU2a6OjhZsI7Amroe2wnSzBGPHW5cxfcA7LU40ADT6CBmYcT1V1xkGQ16buHV1VDYwfqINz46gceVibkFbP+FmnYdTp7eKV/DUpMOOLB8QpMWbjPD85kpJAUgAtj4mSzrZ/WXR8v2onjm7PT2zyABV3rTt80ZjSDHCvFpQryhgBYHSojzNEawppnMQ1Ik4SknTpGhHmp081FO9rU95M5utTTFHF8wvqGlfLnYAiF2iHK9gkep948hioEhlNoW7j3+27c/61fUpVcCq8nGSyPzmgpSIcaVhSDk0Pe/vDT8zDWYcQ2oYYxeI/dCbDKqjhvkrKvWgJBt7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+icA7PhvM//zDaw4/TjZqIAUIagH3JKjLDXdWPvDKw=;
 b=PdKx48fZTvBti9DV8tsyyZMpkCTPgsRcgXgQRgMDaNMrKcpq75EYEk9966qUWOcrhqCrEYb6zvjqKjZcj20UYw7yV98PY0WS/oVl5ki/sLcslMDwuHTLZZ+6U+KBV5BXjsOHCquZLEk+TEeMXqwllgbuo5P47popiHs0U63SMvI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by TYAPR04MB2493.apcprd04.prod.outlook.com (2603:1096:404:18::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Tue, 1 Mar
 2022 12:42:41 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab%3]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 12:42:41 +0000
Message-ID: <9bb56622-2859-1059-6f14-2242ab6a2427@quantatw.com>
Date:   Tue, 1 Mar 2022 20:42:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v4 2/2] dt-bindings: hwmon: Add sample averaging
 properties for ADM1275
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220301103900.12637-1-potin.lai@quantatw.com>
 <20220301103900.12637-3-potin.lai@quantatw.com>
 <da4ac970-9e7d-c9cb-eea3-e5ec8a1eef00@kernel.org>
From:   POTIN LAI <potin.lai@quantatw.com>
In-Reply-To: <da4ac970-9e7d-c9cb-eea3-e5ec8a1eef00@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2P15301CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::18) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2198814e-56f3-4fcf-4657-08d9fb80f98b
X-MS-TrafficTypeDiagnostic: TYAPR04MB2493:EE_
X-Microsoft-Antispam-PRVS: <TYAPR04MB249313EF8467CA81C30A33FC8E029@TYAPR04MB2493.apcprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uZGaS4oj/sG9dA0CGZoSlL3ypZtyYKxWVYxvE2SYBXAI7w8DsHfwy+rpUhv2+nem8RmUkCTYYr2Yb1a57sLC22HSWNmcEQP/kweoZFmBjItdPhnLB1+fc6UDtivaJfc5T/ZxaC4ixoMDLWOV306CerGUNSjQtQI9dHdVFsJ4CR18kbKsBqf4pCEOidetpiUOXMAsVGg2pymPiDlD5OuBgzBMmCKemY4vDipigYzf7qOcNdvh2/fkP7Y1NfI78ucFHjD+D8s3mQl+XfdyfYyhmA0hOUgmNvMaptodkYK1WpNw3KN4z+C6M+tV7cdX6pG443vuzbcIy6vrGdXcBUUx6Ya7K5Y46fG8MzPnv9/bxBzKvryPAFDEiBhFAseULlGMU33SVtcwLHr/74pGPfwVijh5fm23bqW4QzOymJYYrEB7xNdyHO9fnr7m6ne0cAo3kkyajRzU1hWOI5/MlIk/wVp3IMDHzs2Koz8mb5OGk2ivLlLIO5VhVWk92NL2TiOoqeR7pIAYuFPsP6Q1WDhNDA1ovnsNd2/YZuu5QLy0bipBqZYbyOwELsgbPwVAsMWO0HrB32lSUx3i9yHmxX/cMlPQh2vigkqjwinaKcJegFJZPYAUEyq6qtsdKJaP0hn30rtDj8F/Nj+lT/5wJSgOzGAiSrIaDXRywpJYqcCq/m6i3XQIQoc+LpoYLS1cbkMljcc6i0bdocioeaLTcs4UtN7MfcKkF0ZSkcCPraA5i7Hn7B8p3nH7st/pCYvKF6zVRaKpktslL/3JNpeY+ZuJbuBBlRj+hmeKTOTM8tyRzws=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(508600001)(110136005)(38350700002)(2616005)(6486002)(2906002)(6512007)(26005)(36756003)(316002)(186003)(38100700002)(52116002)(53546011)(5660300002)(86362001)(66476007)(4326008)(8676002)(66556008)(6506007)(8936002)(83380400001)(31696002)(66946007)(11716005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWhMQWhpeUU2Q1RlN1ZZT3NDUmZoU0loV3ZZREFqQkhnV0U2NEpTc01IbUoz?=
 =?utf-8?B?dnc5MEtPd0cvWlFWN2R2Y0FUaXAwM0VTeUtlbnpnR01PcFQ4K3NjUmUxVXpn?=
 =?utf-8?B?WTk0ZW4zMk1OR0R3QTNUK3lJbi8xZ01sNm5ackhVeEtjdkRPSkN3Rms2MDZz?=
 =?utf-8?B?ZVlCalBjaHJiNm1NUkJBb1ZBdmFaejc3bWFBZEJBcHRVRnBPcUJ2dFpqR2to?=
 =?utf-8?B?QXgxMjI0YVF0aVNHcU9Tc29DVW5aV1hURG5TY05USnpwMVcvbzh6SU9KUU9j?=
 =?utf-8?B?OFI5N0o5ZHk2ckMwVi9mUmU1eWV5cm4xcTR0QVhjbnZVUVJaTDNNRHFLVmZv?=
 =?utf-8?B?R3gwaTRMakhFc3BLQ0MwMEFTUDU5dEk2bFlrb0RhRktCcDNNWHFoK0g3UFRO?=
 =?utf-8?B?RDI4K2xVbSt2Sy8rcDhHSTdTcFZhQmx1UVdHVHdzQ2lxNWZDMFlrN1FaVXY0?=
 =?utf-8?B?UlpCWFhoeUdYYXRISHpacFlVSGxzcHdUL3Rpb3hybzZkLzgxeWlsZFlHMUU0?=
 =?utf-8?B?aUxlU29JbTZ0Rjlsa0RZK2VNT3VOS05sUXkxdjZRT1RLcHFGclBVQlQrSDBE?=
 =?utf-8?B?a3ZENHZQajl5RUpZVGw2ZkFybUY4Ylg0VVpadUZzenZML2Jkc2czZzcwQ1lv?=
 =?utf-8?B?Q0lpUERNQnU3UGM2ZG4ySjBGSXExZHNWS0ZxUHpqMEZDQTJlM2RCdEdLeGNP?=
 =?utf-8?B?bVpvaktlMEo5Wk9hbFpkWjNPSVRPd2o5M3k4dWgzdHlhRUI1eDh4TlltdFBT?=
 =?utf-8?B?T1EvajBYdnNoU25rZUUybkpOUEJmbnJuUDNTNmIvRmE5cHBSS1QxdVJtZ1Vp?=
 =?utf-8?B?dkt1N2ZKYTFrSGRLTlQzOW5YVGhCTk1KT3JuUGV6d0VWc0lzdEU1aXM3NFB2?=
 =?utf-8?B?bnV6UXlIdm85RkJJdGdHUUlnWHpwb3pIK2FLSFc1dVFtTkZ5YkpmMmJMUnBI?=
 =?utf-8?B?OHVEckxKelZIYmc1SXNYcVBYTk10UWRtTnhwQk9xSTZ2TkgzNWt0L3p2Nk5j?=
 =?utf-8?B?aXRTZmJ5QWpMRk1oZ3U1ZUk2TXRwVGhqR0hHYTZCOHkzSHdmUmYwTmtkTDNx?=
 =?utf-8?B?VWx2em5xMmVQbG9TREkxeURMbkhMUi9jN3ovWS9mUHV6T3VlUjY2TDA3N3Rx?=
 =?utf-8?B?NGsvWWZudVQwbFBOVTlqbkVvREM2aDhPVngvMytJWVJBZVIyVXUrTHVpSFc5?=
 =?utf-8?B?S2c0Q21RUm0wVTNMWHlKaEd1cTFLNFRWUk9tWTFRWXFNM1NKZEZSVFJUaWwz?=
 =?utf-8?B?Rm5GOU5Dc0ZuM05pWWpqN3hSazhrQWg4V20ydGZhd1R5RHRlVFpSTTF6RmdF?=
 =?utf-8?B?U0JFMTc0MzZ4aFhadXdkRmp4a29LcEJ0OHFQeS8wdi96UHNFbDRVMXJqMGhv?=
 =?utf-8?B?RXBlUFVSWjZPVG5nczcvYXdIQkNiOE1hN3ZHQnE2TnlqWityNG9LQ3NlK0hy?=
 =?utf-8?B?YkhubWhjZUVZK2pScXZyOHAwRC84V1o5dTcvR1dNaTFxR2hQb0JlbmxTSkh4?=
 =?utf-8?B?L3hnQThiUFVLdmVRMjVkbFBoaTJjbHhyVThZQWRoMGV5eVQwNmRTeWFCblpO?=
 =?utf-8?B?bGNjUUNoRXpFUXdzYjVxajZvN2Rma3lySlpsRUFhSXIrY2E0Yi9PSmpoeTdi?=
 =?utf-8?B?TUZBaGJ6ZDc4YUdpS0h1V2htTTViWjMrVW5OL0wvVmtRUXUxelJMalYvZXlH?=
 =?utf-8?B?ZHp2KzM0Y3c5K3MxcUNvUzAzRWpHSW01ZWFxdmVtZUZZQk1OZ2cwWkNKYXhG?=
 =?utf-8?B?M29UQmsvMzhhaSswRE5TaEtyUEFGajJOU1BjSFNmYmVvd0ppTXlwTjVWL3Rw?=
 =?utf-8?B?SUZvWG5lMXhVMXJTbHNoLzJKa3BQR1dwVG1zUFR5bG9XOWNseERsbSs5WFk4?=
 =?utf-8?B?YmtoYjVGN0Y3bUlNYlhVRnoyZ25xT2xvaDA0Z3U1UExRM08raDN0STNZUFNi?=
 =?utf-8?B?WmQwdkkvTkZRQXZ4ZjlwbFRJMGJmR0xLV3RSaWNZZFdIQ2JiUHJuOUk2TUwy?=
 =?utf-8?B?TTJyV0R3Vk9qSDYvRVBVWTlQWWZLWTBIcEg5RTBBcDJpbTl6QUJQWUp4cWtO?=
 =?utf-8?B?em1SSDZYZXRrTlVSM2tiOHpMWEwwV0ltNEZiRmZueGF1U05FQTF4NWo2anVY?=
 =?utf-8?B?akgxbERoTFlDbHNMQlcvVzhqTjdNOVJhVE14Sjl0bFVlZmE0Lzk2ZGY3RGJw?=
 =?utf-8?Q?7Kn3hi6Z6o8VL6a273X8AVI=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2198814e-56f3-4fcf-4657-08d9fb80f98b
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 12:42:41.3488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6k4gH+AKuyilRK5hfo1dV3zkV+oUB5WqCf0N03osTH20iepFcLct/CRfRIcRKV0AwNAVZVY/lP5E5VTj7z8IhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR04MB2493
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Krzysztof Kozlowski 於 1/03/2022 7:16 pm 寫道:
> On 01/03/2022 11:39, Potin Lai wrote:
>> Add documentation of new properties for sample averaging in PMON_CONFIG
>> register.
>>
>> New properties:
>> - adi,volt-curr-sample-average
>> - adi,power-sample-average
>> - adi,power-sample-average-enable
>>
>> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
>> ---
>>  .../bindings/hwmon/adi,adm1275.yaml           | 44 +++++++++++++++++++
>>  1 file changed, 44 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>> index 223393d7cafd..1b612dc06992 100644
>> --- a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>> +++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>> @@ -37,6 +37,47 @@ properties:
>>      description:
>>        Shunt resistor value in micro-Ohm.
>>  
>> +  adi,volt-curr-sample-average:
>> +    description: |
>> +      Number of samples to be used to report voltage and current values.
>> +      If the configured value is not a power of 2, sample averaging number
>> +      will be configured with smaller and closest power of 2.
>> +
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [1, 2, 4, 8, 16, 32, 64, 128]
>> +    default: 1
>> +
>> +  adi,power-sample-average:
>> +    description: |
>> +      Number of samples to be used to report power values.
>> +      If the configured value is not a power of 2, sample averaging number
>> +      will be configured with smaller and closest power of 2.
>> +
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [1, 2, 4, 8, 16, 32, 64, 128]
>> +    default: 1
>> +
>> +  adi,power-sample-average-enable:
>> +    description: Enable sample averaging for power reading.
>> +    type: boolean
> Why do you need this property? Voltage/current sampling is enabled in
> your driver with presence of adi,volt-curr-sample-average. Why power
> sampling is different?
For "adi,power-sample-average", adm1075, adm1275 & adm127 don't have config reg for power sample average, so I add boolean type property to enable it
But for "adi,power-sample-average-enable", all chips have ability of configuring, so it doesn't need a property to enable or disable.


Does example means that I can set any type (not just boolean?) of property to false if not allowed?
Could I write as below?

allOf:
  - if:
      properties:
        compatible:
          contains:
            enum:
              - chips_not_support
    then:
      properties:
        adi,power-sample-average: false

Sorry, I am not quite understand the example of set property not allowed, if I still get it wrong, please advise more detailed, thank you.


Potin
>
> Best regards,
> Krzysztof

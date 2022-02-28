Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB6F4C7176
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237835AbiB1QOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiB1QOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:14:40 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2132.outbound.protection.outlook.com [40.107.255.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2EC4474B;
        Mon, 28 Feb 2022 08:13:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkrSHxldsC5USziZtOQmK2MqUbS7sVBjpGhP8iQPQvTKKz7qsIKTGxkLqkzOcHKvaqu7Md5upn4TqYUB19ra6qWuff3kdVi1O3l2RVW+TKPVqqBomRw5UPo7oau9xRS6dB1S9a6Iq69Uo710us3Yhd7YFA25AjHXCmAdNWnImSC5EwDwzQ4ofAFzZyTEigXYA/+Gq4OiNgTCJBPYtl6qWHAd68xaPGDUzpYUkPouo7ANLk9wmyr+95aTY2MwkYMnId6mQWQ8VaFZqagjQQYq6qWn5kV9swg2/K1TD56H26BGoMrVAR1ps8uTKzY3dqyOwL9637uQLVNzA0cdplGlsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUkjEaT6uh4G27Nv/ycDTch5QvOc02tK8k/waMC2lkQ=;
 b=Cg71fHG6GuP5t/zURKQ2KfIuyGquwBF5SO/0dZXoT3W/BvFlJ7K24oUiGEL9uDztJ1G4AUNU7KLM20zhDWpRNBCIoGlB4BduveEcZTzEbQF7Py043gmIOnxYeqwMC2GTSDYErRP/+GxarLOHl0xepgJP28GMLWdhLXmjlpq4nujp+Hbod16FJOAdmCgRwOfWBo1TvTX/RSW63/PWfGMWFYIFDcxoNpt1r0Lj0p9t5KB2gQZMTLnENFQWO7CsiOHPysybNuoCs3RgHAI1j18UDV0pTvARhkY4SjjReDaxoIFMfl8VLGYl67HMEzvnfIjRLXBIJrBbEs3/cbVmd6Y6Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUkjEaT6uh4G27Nv/ycDTch5QvOc02tK8k/waMC2lkQ=;
 b=Iyje6+gR4pL2OeGJ6yCUPbyh7swz64tiWKReVBJLBN6GKG7GtU1381f2/MY4w3eCOQqsiHMuKCLAcCHFiy/BKneYP4T8ss1P1cb+qy2ZMtp9fzPT2N3GT7JEW4ID3mYaQqy3N0DWsbKgEqeZMHdjLp5kJzTTcQyF9PvhDvfsSyo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by TYZPR04MB5121.apcprd04.prod.outlook.com (2603:1096:400:12c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Mon, 28 Feb
 2022 16:13:55 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab%3]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 16:13:55 +0000
Message-ID: <aca659c8-558c-7091-f2b6-37ef478a14db@quantatw.com>
Date:   Tue, 1 Mar 2022 00:13:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3 2/2] dt-bindings: hwmon: Add sample averaging
 properties for ADM1275
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220228103716.10774-1-potin.lai@quantatw.com>
 <20220228103716.10774-3-potin.lai@quantatw.com>
 <062ad1fb-269f-2a43-0f47-46894bca426c@kernel.org>
From:   POTIN LAI <potin.lai@quantatw.com>
In-Reply-To: <062ad1fb-269f-2a43-0f47-46894bca426c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR0401CA0001.apcprd04.prod.outlook.com
 (2603:1096:202:2::11) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4943b7e9-3cb7-4ea2-13e1-08d9fad55151
X-MS-TrafficTypeDiagnostic: TYZPR04MB5121:EE_
X-Microsoft-Antispam-PRVS: <TYZPR04MB51213E49BAEA7982ABAA18988E019@TYZPR04MB5121.apcprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hieN023V7EH/lZSes8pJ1B0+0+PyzQkp5NBc5/6Ee1/8NyuJD1ZqWrRge3pHHoI/1BuKEqwINORvNZFnMn5n+xVjHAFy0ZQ9Mhr/b3U6LX+HXSIjESsxjUnMXqiszxzgJMD8sW+wTWgNArJZKQo6iB/HD3aGRkHBfej8sGlt/eP8dWhjj0Oc0g9KUhv4p03hQPHudqCei+mwHVDyYVlVaGPY9FuU2RqNHAXjgpgCSTJTNy7LtAVi3YwNPPxBN0LQVVoaAFIeXm6NAkGK66ffI6f448hh2VrHc91GGIDM5y5qKYze6mu5NwFL9cY2sXfh+XKOh6ZpdKq42zSX5DqM9H2+Few9HC9Re6CLIqDffZw/5Pp7QV6ON3bz+WmpHSQTvYQnWePl22w4JGqcK2VHgUzVU23P0donaqUmU4kBYqih3Q4DcyVdB1P03zxKZ7mLqhNabVzfysUvvXsvwxh69EojpwpNubvlQkXlWKdjkUKKcTSxQ8iXV1hcBgdlSYM6wKXGYkwgo18BJRaKNcCG4YF5zHdu9WzVEl9ivkArwEOJGdGpW5fePR0FLFu43wNMVfXmmxBvLKXaVMvQC53o4FbZzmEcRpcdP2OaPP+FQy393huKu/v00Dpgs23MB0vACi4JT5S5WRKOcjGtuev+VdCtWzedrOc9gf6FC3HLkRxW5TjSDrHZAJ74hQGrut8VcGc4HMFSaSH/eciw2daSQy/wxie3G4KxM7rIpUf7VRdJReK8hgupd647gfYvrFz6aMbqmh8qaf6BVulIXD51cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(53546011)(6512007)(6666004)(8936002)(6486002)(508600001)(31696002)(6506007)(52116002)(83380400001)(38350700002)(38100700002)(5660300002)(36756003)(86362001)(110136005)(26005)(8676002)(186003)(66556008)(2906002)(4326008)(2616005)(66476007)(316002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVBpNEZMZmhvWDBQbDZTNUZWQ0NUa2l1dlE2bDFVVGpycDgza0FkRi9sQ2JZ?=
 =?utf-8?B?SWEzRmh2djNxODZUVW54Z3cvZ0ozdjU4dzhRYWF4K0hHL0dTNEdoRmE1dHpm?=
 =?utf-8?B?MjJodk11TWpWVmFmUkw1S2lJeURoQnJRaVR5d3dDKzhNY1l4amE1anZwc1cz?=
 =?utf-8?B?MGswbE5VRzdidmhlaldEQmNwRHIvSEgwVWYxVmszeTdwRGsyWjF6ZlhhU1hG?=
 =?utf-8?B?bXRPelhUSWZzZVFmY0dEMkJmUEdWWWI0V050NlNPMFQvY0tKcXhhZjdqRVNz?=
 =?utf-8?B?d0k5T0kzQjNvVkpZSmR2L1NUTFZ6ODl3b1ppdk5BbTVjY21KcjJZUFljSDhI?=
 =?utf-8?B?RGEySlhzTVYvb3lJWE1MNWxTbmJPamd6RlBPZlZpUWN2OUdvQmYrbVFkb2pS?=
 =?utf-8?B?ZjN0dktmZmt0QlpwTmJzMnpIQXo1dHlaMk5SNWhnR0xsYktuRjRJOWoxWjA4?=
 =?utf-8?B?NUxLOEhRWDNYQmcvUDBId25CLzFZVDNVM2pMYVBwcjQ2cG5TUVRrYlRIeG9y?=
 =?utf-8?B?bzVNQlJqSml0RVFDTVNhLzkvYmFRbDQxNnVGZWRubnhXUXRPWG5wYjJaeFhj?=
 =?utf-8?B?VTJocXJ5NVJhQnJnNXRUYktuamhxUjZRanFhQ3VHTUs1cldSMmE2RFdWVTFz?=
 =?utf-8?B?RU1OMzR0Wm4zZ1k3ZGo0ZXdXVWxOUlFuZ0JlY3pjNjB1L20xRzFHVGZDVXU1?=
 =?utf-8?B?OUhNdndORjZzR0s2a0orc0pSenNuSHdqMVk4SUo5dHJtODlINDkrWmVjTFFu?=
 =?utf-8?B?b05sK2VHUFFGK3NrRVd5Y1VhYUNYdGhHQkw3dzRpQkVUczBENzVsN200bTBk?=
 =?utf-8?B?R3NkMmJzRDVsMFgycjlYWEJEQW5qRnJ1bFd0MTZDbmhOaEZYRHlza3FHa1pX?=
 =?utf-8?B?Zlp4YnBxMnp3TzlrQVZEdUlTc3ZtY3VtWTc0c0hlL2R0LzNqMkxTMFJRNkQy?=
 =?utf-8?B?Y3ZFUmlnVExWbGVyUjNVblRFbUx6Q3hCeExWb1d1Tnlub1lQQ2dhSzBWZVIx?=
 =?utf-8?B?WUl5d3cxako0bkp1c0QyVHJxeXJ5d3FObzRBOHpBMER4Z0lBSTdQelJvK1Yy?=
 =?utf-8?B?REwwUDhLYi9idFRtS0IwVUdIRkpvdzAwWUNaVVpDbUpvU2hQRWErVi9ncmNJ?=
 =?utf-8?B?eTlManBsWW5xZFJMbW9OT3dvR29KUmlnYW9xNnBOaVR2Vm4vVVdiT0JxQVls?=
 =?utf-8?B?UkxRU1h2elRKMytlSUhoSUNuOXUxTEpnZVZ6cVhFUEFqVWhaSVpFRktUcGVN?=
 =?utf-8?B?OUExanpZcWFqYnpKTkFlaG9pRk5JbHl1MW51VW5HWlpFV2Nwd0hhTEhUdmJw?=
 =?utf-8?B?NHVPc0pUcEViOWNVcWNHUVlpOFZrMDEzRzR4Sm5jWTlib3phMjBKdkppbTRW?=
 =?utf-8?B?eWlUOVRRcGNZN2UxbVBDYzVDWkl2NnRNNmhaMlBwclZYMzlQTXg5b3p6RUpH?=
 =?utf-8?B?YTh5TGVjWUVJWEJML0xHVmRTb1luWE1OVDBNcnB3cXhQSThvajBGRVVpbGdV?=
 =?utf-8?B?eXNhNWFBRVJGdFJ0TElUQU4wWUR4RjkrWHhkYmVpeXphNzU2b0tRMldVVU9J?=
 =?utf-8?B?N3JPUDJiT1gwZWljbk9KWUk5ZzEwZGgzYjJHaEc4WWZ5MU5TS21aOVhGTTVo?=
 =?utf-8?B?WEFOditjaURUZXlMUWd6bE04cWZDbWlwd3hmZm5XNjJCVUpyTzZwbmlVdUlI?=
 =?utf-8?B?c1FxSjhVWTBTR1dLWjF4WUhMRFhVNURHOU1ISEo2VVZVeGlyRlNsQTlpcFlL?=
 =?utf-8?B?eGVndGNmeEFvcm9tRDlMMWhybUZLZkdQV20zUFVFT3phVnM4cEEvQjk4RXZz?=
 =?utf-8?B?Nm8rcDh5SnJUcC9TQVdBcXRwYlBQS2xVdFRkenBleG5rdVFJcVhXcGN0c1dM?=
 =?utf-8?B?SkpDQ011dXRXYlkxN0VaR1N4NDdDTFA1aEExWDFSTW9tRTBIeXZ6VGpHam84?=
 =?utf-8?B?TVdlbFBaZ1VCKytiZWVLZGdpcGhzdGlmWDU1OVJ2N1pnZ0JTY1VpTkk2OVFl?=
 =?utf-8?B?Wjh3WmUrd3IrWXZhQlJEMGZjd2lFRG1xWU4xemtTbDV6Wm1wa3E3cDRmYzZ0?=
 =?utf-8?B?YWlqbUlwUDArUjhHR3BoMlFXaDl5clVYbVRwQmlzVGdQeHFwNzd3SmJXOGZF?=
 =?utf-8?B?Q0RPcHQvdWQ1V3RseXdjbEwwZGZKV2dBVFBIaHpsaUpwSXNCUlc2TThLNmNQ?=
 =?utf-8?Q?bBHzV3i73N7WMVd9QkelAd8=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4943b7e9-3cb7-4ea2-13e1-08d9fad55151
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 16:13:55.1381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ratPz8Yt9G2JzqbFdxNe78VMIbbpexJ3MxkjMWHXYJ/usEUAAuLtKZ5zqhrFLQ2AbspOjBUH8rTn03Z3BcR4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5121
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Krzysztof Kozlowski 於 28/02/2022 10:25 pm 寫道:
> On 28/02/2022 11:37, Potin Lai wrote:
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
> You have weirdly formatted commit msg.
It must be pasted from somewhere accidentally, sorry.
>> ---
>>  .../bindings/hwmon/adi,adm1275.yaml           | 39 +++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>> index 223393d7cafd..bc4206b257a8 100644
>> --- a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>> +++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>> @@ -37,6 +37,43 @@ properties:
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
>> +    minimum: 1
>> +    maximum: 128
>> +    default: 1
>> +
>> +  adi,power-sample-average:
>> +    description: |
>> +      Number of samples to be used to report power values.
>> +      If the configured value is not a power of 2, sample averaging number
>> +      will be configured with smaller and closest power of 2.
>> +
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 1
>> +    maximum: 128
>> +    default: 1
>> +
>> +if:
> This should be in allOf.
will add it.
>
>> +  not:
> Remove negation and list devices where it is not allowed.
will remove it.
>
>> +    properties:
>> +      compatible:
>> +        contains:
>> +          enum:
>> +          - adi,adm1272
>> +          - adi,adm1278
>> +          - adi,adm1293
>> +          - adi,adm1294
>> +then:
>> +  properties:
>> +    adi,power-sample-average:
>> +      description: This property is not allowed.
> This does not work. Please test it - add not allowed property to such
> devices and look for error. I gave you the example how it should be
> done. Why doing it in a different way which does not work?
>
Sorry for misunderstanding from original example. I rechecked the example and made a modification as below, before sending out new patch, would you mind help me review it and let me know if anything improper? Thank you.


dependencies:
  adi,enable-power-sample-average: [ 'adi,power-sample-average' ]
  adi,power-sample-average: [ 'adi,enable-power-sample-average' ]

allOf:
  - if:
      properties:
        compatible:
          contains:
            enum:
              - adi,adm1272
              - adi,adm1278
              - adi,adm1293
              - adi,adm1294
    then:
      required:
        - adi,enable-power-sample-average
    else:
      properties:
        adi,enable-power-sample-average: false


Thanks,
Potin
>
>> +
>>  required:
>>    - compatible
>>    - reg
>> @@ -53,5 +90,7 @@ examples:
>>              compatible = "adi,adm1272";
>>              reg = <0x10>;
>>              shunt-resistor-micro-ohms = <500>;
>> +            adi,volt-curr-sample-average = <128>;
>> +            adi,power-sample-average = <128>;
>>          };
>>      };
>
> Best regards,
> Krzysztof

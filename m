Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83EA50EAD5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245661AbiDYUuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbiDYUuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:50:08 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70098.outbound.protection.outlook.com [40.107.7.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CFB3FD96;
        Mon, 25 Apr 2022 13:47:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThdOY9e/MgRD/p8cp3+X8Hc2zHA2xzpoONMfysd47ngkZuY/NU6nwyKEaUHdcw/jEkUqoQikairUOhOglBbAv56SRZ602+XeL7rgOOTUf3ditZIKV+Te4WD1E43jT+wUmuBSUNtfyzBMVe/obHyfXDIlYyYHFeIgNOQ/OL5XU3tiEJ1o1GCRUMSMVg+vZBXP3o2hse/GFPgEL+m7MczuIkEkz8el1t9/aTmAbK2JCZKJ+/dXHAtvWCmJr/df5egFLMzbaLPJhUFG4VtXj99jEw8SELy9ywbO0NMSHicmiJS5K/EbzEAqKQz1dl/BJeTXA8+sKoDSBjITn9ci1fYz7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=labTMYfofzjufuRizdHgz8xBzrPKWFRCltzNlFcZorM=;
 b=lR3zuhvLcQ9RPm6UOzs4bZy4ppNs1pFHQp48uCl7AVwNM8v50x/DkOrn90cjCkTQXnkmdKtSMJ/hTZId6oOF5kFZaOf/U0ILcTLwYfw1Z2vtsp9KuGE1CRVqzYSW9Ly3m4w5ZkH77hoYuIaqLTl37NlE+eUzjBxNvgGUn/6nkQzSRK3jvK9P5FGyfNMw8KokMizQ/YJEgCkpNZgOaCEFr4BmZhxSDMoG0zSZxtRdGWN0c8+JEPC18MnCXzKO/CG4MKW9/FvYRzI7S8q7mjN/TBm/248eom1g5vxUIFV+ziokOwH67Z1+hxh0ffcO4PLtH7TPKPo+CraYLpF6ciYd7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=labTMYfofzjufuRizdHgz8xBzrPKWFRCltzNlFcZorM=;
 b=AukHLGoYf1KIwb7Z1YZ1JDJlVWk06ZCYPwO83uS9A198S8mURaYOSCgkp6/BrfDFfLyBTYKgj6T96ge7P/9bNUon+ypfKEcSbGmmZnDZuNCLZZKKvrHWs6C1/GS8UcuPPjDPY9+OnlHLaCuPTcy3En1bLrh/vX6sz6m0A9xnsLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by PR1PR02MB4937.eurprd02.prod.outlook.com (2603:10a6:102:e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Mon, 25 Apr
 2022 20:47:00 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423%5]) with mapi id 15.20.5186.020; Mon, 25 Apr 2022
 20:47:00 +0000
Message-ID: <a230b7a8-4146-9483-48ee-0bebdd945731@axentia.se>
Date:   Mon, 25 Apr 2022 22:46:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: sv
In-Reply-To: <42db911c-5eba-0511-3e8c-8011a2a5b44a@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 1/2] dt-bindings: iio: ti-dac5571: Add ti,dac121c081
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0087.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::14) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2b6174c-d050-42ed-9135-08da26fcbf0a
X-MS-TrafficTypeDiagnostic: PR1PR02MB4937:EE_
X-Microsoft-Antispam-PRVS: <PR1PR02MB4937BBB80C22585DB826F4C2BCF89@PR1PR02MB4937.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z9JwsZyYPMlGcJLYcIYvpTjp7eG4RO5HEe/F5kL21nspeWNOsLv0udzcJaq4lzxFVsySX26YHaq1wYjYcsuPQ/Th1ElkyC9Qf9pMC4ioMGcF7ElhU6ODxxgkMreAUX5bEDLKLXqd4I1r8apRFQQfK48BArPRyEzlmsesakl4GvPuvlpuu87IEeOaHDqbDMCj4ZbKtH5l9vx7ILQebY4AKne7BGSu38BqSaAHq9TFjztD/VTgEYEfuNob+vcb1zZZ6zcJrT+tD+DLuiNJEFRil2CaGZucYJLBunNtD1GtZ2K5FLg1wGHTgH1jPBkWDs9DYb7o/AIX9Gw3ouflYQEBbumo46wo83FscOdpCIXxQZ/ylqbhAmMSDBUHSptlDGe5O0oZIXt7GuFlv81zXC+BWYoAm01vrDjsV897mOYJ4NExHglHtdpyM6R9BeDJTT69vORK0mk+iNpQZcb4DzERgH/ZCBWT+ISaHUJNiaJKsE19mwaW7kLjeK0RCO9oIVVjFUcMKGU1XmrE+62p+4CVNvcfYD5T18RY+xFn/XSXFtMHPEYOLxlcHLf6RXtPyzMzF5gND20CyvjInOTMzBok6fadFK9EGi4BRQ6coqsPi3vVPdbWEqP6EEj+6YI8kLExp0BOKYUTyZtX1zEK37aKNhCBuqhSBwc0vfv91iKJg5sLT59vwLA7yZ3B1bFx35BhH0UESyPssEM60cIzEr6lCkBZ5su003KCcrchQxANvwg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(346002)(136003)(376002)(396003)(39840400004)(5660300002)(38100700002)(6512007)(6506007)(316002)(86362001)(26005)(54906003)(508600001)(6486002)(186003)(6916009)(2906002)(8936002)(4744005)(2616005)(31696002)(4326008)(8676002)(66946007)(66556008)(66476007)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXo3c3NqVGg3YWhPK1J2cGE2L2U4bC9QTHdWaW1RUGFtTVpPREE5NjJJVlZZ?=
 =?utf-8?B?SFd4dU5FVmJHeklhUUU2QlZVbWh3aUhGWVBqQW5OZWg3SWZyVGVvT0FWL0NC?=
 =?utf-8?B?Y2ZPdmxDZzNwRTIyVjNPOWdCeWE5K1psa0ZKOHhWRUUwSzdaQk5Tc2JVT3V4?=
 =?utf-8?B?bUVsanY5aVNtYS9LNUhCUUpMUkpTSGROb3VlczBWZWJ5b0MycU85dDJHYzhU?=
 =?utf-8?B?MDBUbTBBZTEvMEQxZG91T3JUM2tMbllYaEQ0SU9keitUY1NaK2VNMWFWckNp?=
 =?utf-8?B?NUxESGdERGU3b1BpRjhFWk82MjJnSVJuMnNDNVBZcjMwS3U1VXVWc2M0TEJy?=
 =?utf-8?B?NFBmcXRybksvdWY3V3Q0MTFoMkN3MlpRQUF2WENscVg0WVdZWm1pNURDWHph?=
 =?utf-8?B?bjBGUnJJWTNaL0FGaHJMams3NXNtRWVkWlgyNVA5MnRVZlFMaWgxRWI5bW5i?=
 =?utf-8?B?SjlwL0FlcUxUOEwzZUdiOE05bUs5UXcwMWdGODhFZWRYT2p6WWhtcFFlNm1t?=
 =?utf-8?B?c0dHam9hZFZPbEF2SkdYbGRkNkkzaUJNSWE4VE5zbE1OaGsydWtPSERKVkZZ?=
 =?utf-8?B?ZlRMVjdSVzc2dC9sYm5aZDUyajYrc2NNRHhpU0F1K3RncnA5YVRrNittUURH?=
 =?utf-8?B?TnFWTWczTDU5Zm9hUEhWaFpEazdWQnVoZVlkVVhqRWppYzkwYUJ3dkZBcTlY?=
 =?utf-8?B?ditmQk00aFBYQ3RVbjdCQmk0Q2RPYVkyYTlTcDVOc1lCVnhOSXFRTEo3SGFV?=
 =?utf-8?B?NjlEVzhLTFArNmNiQ2Z3a05vU0FuSTk2cWg4UmoxUVZPbm1vazc1Y01JKzJv?=
 =?utf-8?B?a1VvOTdWOCtKZzY3d2VjdjNiNTVseU1QTW9JTUVPTFJrckk1SEZ6dXd0QmNZ?=
 =?utf-8?B?bkNWbXFXWW43UTIyUlpwVllhbkZQL3hkMDFQSDh5WVhocFQzTjV6MHkwb3lK?=
 =?utf-8?B?Z01vQWdzN2ZrczNiM2Nwc1R4T1dTVk0yNnBLSGRsamdxelZLdWNPeWdWeFox?=
 =?utf-8?B?QTJzM21idjNac1dGTXhmYWJ1RHJidTZJU1A3SmY3QmgzMkx2QzRNUU5DbjFB?=
 =?utf-8?B?ZC9LT1pPNDhQYVd1QmZjWENIVlR1YS9WMmczY0xKWTQrSUNUQ3EzRzlORVdj?=
 =?utf-8?B?SWtvQ1ZqbWNYck5XRlc4cUZ0di9haW94SDQ3eTNhU09iUnRONDQxbHJTTVZZ?=
 =?utf-8?B?KzZwQ0lLd2UrdHdJWktaY0hXWW9EZkNWWmVsS2ZhcUF4S1NhbmdtcmV5aWxh?=
 =?utf-8?B?V1JUUkM4Nmg0S0VyMXpyRTJxZDlRbE9VRGNQN29kVU14Q3RNSVNaN1lJRTZy?=
 =?utf-8?B?SDFkbWNLYVVNeWY3YTVaWUh2Rm1aN01aMWs0cGUweFRpbTFkcXd6QURyZXZp?=
 =?utf-8?B?TmZzTDJJaCs5cEJMWEl0Zk0wQ3RjSkRMVFdqdjBwTGZMZnpYN2tVM2V2QmRI?=
 =?utf-8?B?N1dCY1orTEp3dkV3bnYvckFoVS9SWlVsTlU0OW1PYmZRai9JREowTS90Qjdp?=
 =?utf-8?B?YzkwMEdxQUhTdWpNQ29MVTdmY3NOQjY3OE5PNDBFcVI1L093UnplTWdIeEJh?=
 =?utf-8?B?YmFVQlJ1RjFwSm1VbmsxNVJrSkdzWjltR2VqalN5Nk10MmVaOVU2ZjRNM3RZ?=
 =?utf-8?B?aDV5M0VLaWY4VnRxR0NaQk9hMUgyTlU3Sll0M2o0OGNBQ0VJRTluaVdGZERT?=
 =?utf-8?B?L0RUOTJHcHY4N3ZZOGdheklkRnRFTlY0NEoyV0Q2c2dCYU1VVUtJcmpETUJm?=
 =?utf-8?B?azBXY2MzaEIwb3NOQy8wNVo3Y2x3eVpzZTFHRldrcDQ2VG5KOHE1OFhtcDVh?=
 =?utf-8?B?M3dVblp1MzFMR2ROT2gwTlRkNWIybldydEorNDhLZysreTVPS2JqYUhsM1du?=
 =?utf-8?B?N0VWbWNjb3V4M2NTVUtMbHh2S0JGWXQ4THMvN0VDVUZLdzVVYTRySU5HbXVV?=
 =?utf-8?B?S014QWxiRGdzNUl4ZFEwQ1A2VTNTMjFEcnJBa1ZoOWlNdkl5elpOVmcyaUli?=
 =?utf-8?B?aTR1QXRxSGRUSG5OaWgwK3VlQzlza1RLTjlCcFY0cnlGallucmI5VTFpaU9T?=
 =?utf-8?B?bWZGbDlWcEFpMTJ6VG13b0p2WWdiRTJ1bXFZcDF4MVp3akFDQVR4L1FHaUor?=
 =?utf-8?B?c0k0a1lhbEZwTmwwWW8rdTMyYUdMcU1LN2VGTWUybjVWWjh2eDlUMGptZ2pH?=
 =?utf-8?B?Qm5NRW1CcHk5K0ZVWVJDSjJ2Q0JqY1dPY0JNazd0NEFOZ2taZlZ5UkFiNGY1?=
 =?utf-8?B?M093T21KNkRpR3BjcnE0a2JuVG1WcmJaUzJOeExlZHlLSnNWV2V1VmJpT2wx?=
 =?utf-8?B?cCtUOVBQSzJPZHVWS29rcUJLZlp1NmovZ01sZEc1a1pTRjQ2Uk9vdz09?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b6174c-d050-42ed-9135-08da26fcbf0a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 20:47:00.6351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43noDhQzv9fLh67slLgibSJEWvBJxD5qCHqbBtC3MJ/zBZg6pDv1sQJ5CXyqXRp+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR02MB4937
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It works much the same as ti,dac7571, so it fits in the "family" even
if the name is a little bit different.

Reviewed-by: Sean Nyekjaer <sean@geanix.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
index 714191724f7c..88298bc43b81 100644
--- a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
@@ -21,6 +21,7 @@ properties:
       - ti,dac5573
       - ti,dac6573
       - ti,dac7573
+      - ti,dac121c081
 
   reg:
     maxItems: 1
-- 
2.20.1


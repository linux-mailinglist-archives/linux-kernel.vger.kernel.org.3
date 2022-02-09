Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908594AE88A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 05:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348101AbiBIEOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 23:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347362AbiBIDnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:43:55 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2111.outbound.protection.outlook.com [40.107.255.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672D2C0401C2;
        Tue,  8 Feb 2022 19:34:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhqVR3Nak7kkIeMJwDlKkDaD8sALShvo8+p5ZpwEVK7cGp8cgpM51A9IiCLqqvh6eQnE5OyyL/qAeqIykbOZeAvSUco4fxGAJAnJ4WMLx4XzKDocZs727ohHUlW2Y2UQpkQULCjOd5leoXpPhAyVROJFTx6X0Naf4j4gdWF1TF8dkOFBwRE4+0ojVxLhS16HJqq/hR7mBjUXYXd/CNFdM9h1XoTI7k1QwVzZVK1Ozsl+LjWh9Rid0psbZOlnyuDSyoX5eG2NrKvDDbKHrLc1/Kaxh6S809AS6i5Ctfi0CTEv/4vozN1l4j3WXa/9j2E6Z0tVcYVBbHjFSRYnhgH/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kt8Fp/Y/pmQcZnD69FCQva2VMtd4VeCEv+SvtIlJAyw=;
 b=UvYvReRV7/wKC8qWc0gI0x17cPMS9OvvXs2atZX7WrUI83fSJgJ14wq9mm2NKrS7ZarvJtK1KIgF3Qb+mwjioHzwWv0lZelffEp7yxbceDxuDIR4b0nvf4nq7IkB8seLPJsBdOujyxa1plbzZyyqLdxnyPJtVhz6fahZQF/AykMovDeSj73VTl9HkfzkJnhA9tX0lU1wQ+lNJI7AuJwVfGUYEBCKXMcK74Iv10ylQqGQ9Db4oZp+7XfdCLqpCCvzWT7C7E0X+yY+rayPxmlQ6kaIymJECsZD3pE2JpcrEa3gxDIT6i2MOKN9gVox/3lsPxw1aIDmnqm8Ve1qiS2lew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kt8Fp/Y/pmQcZnD69FCQva2VMtd4VeCEv+SvtIlJAyw=;
 b=CpQMWbU3JICDipVabzZX9XCdHn25PN97GGlzkOOA+LUms1P5QjvHuKmY4EG1j8aN82OXmNWvT0RtE9rAMvUWfs55Mal/USCPiQI+5qlzKcfwgzCXrgs5sU1hjR6k+raJUHwl8Kse8fsBpom0Y6LnfK3sjjEAQygUFNgycTyf0n4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by HK0PR04MB3025.apcprd04.prod.outlook.com (2603:1096:203:3f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Wed, 9 Feb
 2022 03:34:24 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53%3]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 03:34:24 +0000
Message-ID: <fed6bad9-bf9b-90b5-57fd-083401f6c990@quantatw.com>
Date:   Wed, 9 Feb 2022 11:34:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 2/2] usb: typec: fusb302: add support of
 supported_pd_rev
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Patrick Williams <patrick@stwcx.xyz>
References: <20220208082026.4855-1-potin.lai@quantatw.com>
 <20220208112226.9108-1-potin.lai@quantatw.com>
 <20220208112226.9108-3-potin.lai@quantatw.com>
 <1acc1733-da53-6255-5cad-15f79850f44f@roeck-us.net>
From:   Potin Lai <potin.lai@quantatw.com>
In-Reply-To: <1acc1733-da53-6255-5cad-15f79850f44f@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR04CA0073.apcprd04.prod.outlook.com
 (2603:1096:202:15::17) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d4cdf85-9be4-4bd2-7d78-08d9eb7d117b
X-MS-TrafficTypeDiagnostic: HK0PR04MB3025:EE_
X-Microsoft-Antispam-PRVS: <HK0PR04MB30258860AAEE705BDCE252808E2E9@HK0PR04MB3025.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fUiQ5FimRcgF+YH1E4sy/s//jrP2sb2OPhgxLj3TomQGXtuPSPly2KDfIBsZu3SwRUt1uIF7JC0QlfMypYxG+BXMiRzO8qu/P9XOM/PaFjjCfzuLFJ26SJtM2ZkV66VJiHafcDlZvI83r6DbDH78v8fkgAvLrAKBOBHu/GXR4pKgCXj4Bpv3qb1QkqOFqKQuZ0Px8djJFgS24DAQO5sZ5UREly/tHAcCxx/OYPkinSbvTFIN1VteYI6jf4GhgInLUU5W/x2S6qpFFLmqKiG81g0Dysxdt/BIF2ESmCj+IogjfC4W8uyt75FovghHnKyTZQR0OGe3v35b5jeCWE2s7OiV1f+bT2NLNUkDsfeMkdKF4d66vTscL8hpy6DBpe63xa1Qz3zepWYzrAY8xZS2EEj4SNFygILTONMli+2svndrnYbiS0egQBBwOxqHR3CqAEQz80dP2Vn2WAqDvf3B6mAhwGvT0COCZswRidEwJFmVladBs3sWsE90YtbWHzo3IfkjAuM27O+m8Gef/xcNugyvzxNlgySvjubWQwyElBVrTJsAZU1YUfxvJ8bojrBeXrwYIDtPcp5wQY8GwQwu8vDjqowI0PyNTGemULdi0VbLvn+Oy1wVJ1gnIX8buJ5ToUQh90Wsp5D7o9IxJM2D23jnKm01suOq/Hxl1WsJM3Pz6qqLkJ2KR7Dk+PPkobTiLXpJAC4lPj4l07uX/Lgf75BjuiYZBrmCIpPJwjN2AN1553DJmoyXJlUTIQktMcRc/Y58MMyG9hDxUk5PzxJ2fQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(53546011)(83380400001)(2906002)(38100700002)(110136005)(86362001)(31696002)(508600001)(38350700002)(6486002)(52116002)(36756003)(2616005)(186003)(26005)(5660300002)(31686004)(44832011)(6512007)(6506007)(8936002)(4326008)(8676002)(66556008)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHN3L0JDa0pwZUZaY2V3a3BoWE8wYW5GOUdmM3NGRGxBZ1Q3M3ZEZmlENUtJ?=
 =?utf-8?B?OS9nT20zVmxzUXJVaG4yb2RrZG9jSkpzdlY1RGxLanZMb1dyalhDSVA5T3hx?=
 =?utf-8?B?ci9YRzRGV001QVU2WEN0VVl6TVpzcmNaaVJERjRaUktlZVFkZXlhTTI5ZU5P?=
 =?utf-8?B?aTNBbk5kQWJSSHIxVUVpai96YU9ET0VobHhNQk1sbGp5b3krRGh3ajZTa2V0?=
 =?utf-8?B?ZFRWcGwxUEJFNytPM3lqUGJEbkpTOVlSMURUTXcrRFE1c3FYUTVha3NBSHhJ?=
 =?utf-8?B?YnRvaDF6YSt2T2RhUEVIYnJDK2NKMVJHaVcybHIrTGFwbzVna2JpWE1EKzNX?=
 =?utf-8?B?SVgwa0l6LzljTEtZL05QS0ZHbWZKUGpwamZTZ2tUMUFoMERTTFJUUzZvbTFk?=
 =?utf-8?B?eHFUNjNpNG9RV0VFU2ZLalpxUzQrVXVFVDUrcW9TLzM1Ym0weitxTEg3Z2Vs?=
 =?utf-8?B?YjNlZllIQnlXcm9VTmhiMVJJWGp0OStFMFVSQWFYQnJiZ3ZHemQ5TGF6SWtH?=
 =?utf-8?B?WlE2aUxSemMwb096VDVIaE8yZjlreUpkNm5lRTFON0puYzR1SUZJSzlMUHlD?=
 =?utf-8?B?MDQzRUZMc1JuRzVUQWQwdGV2UWgxcDdwWVNEbkxzME9tb0c0a0Z6SnJxc1Nz?=
 =?utf-8?B?K0pTaFd4cjA1ejNraGhFMGR4Z0VQUy9OWUJxbzhpbDIraFIxYytlSVAxRnVo?=
 =?utf-8?B?Vm5VZFR0M0xUcGlYNHVNejFkV05sb3BodkRUcGV6VTRwY3kyVk43TEpnT0FU?=
 =?utf-8?B?RXY2RSs1a0EzTGp5aGROb3FOWExaWEgwbkwwSGZrQnlubjVYVCtzQnZPakpr?=
 =?utf-8?B?QmcwUit6QSsyRTd1bURvV2pVQWFqTGxEVmVITHRvWTV0alc1dUpkVTU5amhk?=
 =?utf-8?B?MGxWcmU4QTd0cG5PKzgyZU02dFg5eThITXFCVS9rUmd1S09sSHlwRWlNcWNH?=
 =?utf-8?B?TXRnOUhKLzM0bi9rQ0d1cmpNZXRlYkwrV3REajd4elZmZDV4TjBpNytDVldG?=
 =?utf-8?B?SUl3Vm5palBDUEJWZVpMd3BwWTJvek5BY0JtTlFEa25TbHlqUHlYY2RLVFcv?=
 =?utf-8?B?YkduYkMrMTRHRE9DRlJLaStZTVQ4TzUySHZDUTJUNWFmT3J6OXAwM05JZHI3?=
 =?utf-8?B?TXpWR3dZdXpxNTFodlQrVlg5L3NOTlVxNnN5ZVRjT1g1a3pJQk5uYXBlQmRD?=
 =?utf-8?B?SXViQ1d6SERSWXB2eWFlbDBobG1PNENiaUtJM2lCdXVEQWRLYWtUbVVzVHV6?=
 =?utf-8?B?emlwc0h3Q3ZVSDdpUzFWeGs2LzUvUGJJTHRXTjFyY1RtYmtqUElablFLN3dv?=
 =?utf-8?B?NEY0WlJHN0xzcVFsL1JIclVWRGd0REh6UjV3alF5bHkyYmlEeE1uMFcyYXpw?=
 =?utf-8?B?WjY2WXhleTBBL09xM2dnS24vRUZNM20xV0tDSkdoc3RNaXlOWmRPVlAxMjhJ?=
 =?utf-8?B?MEtDSkFIUVVXcGd5Yi9XQ29UL1E2R2Vkc0xCcmkwU3Y5dnBCdFV0YlhPZ1Fa?=
 =?utf-8?B?WW0yNS9BbVdXUFFxeTdJUFFWWFVhZmlqTFBaYVg4dnVFWEprRFNFRGZVS2Zt?=
 =?utf-8?B?MzBldUNGSmVJMFhyWm44UjNBSkdLL0swem83R2R3SDJTTFhrRGdqaGNnL015?=
 =?utf-8?B?d3BLdVQ4Y2hNeEhUNmNJN3M5UjVEaDhLVm5RVnRyRGp5SjdEZzNJRFNxY2cy?=
 =?utf-8?B?WUkxZHBjU3pyQWprZTcveTIvemVEc1JTa1A0TDR0b1VCQ05WOERvanJBOFFv?=
 =?utf-8?B?M0d4aUtvWXE0bFdtWkhPZWRvWFZXb2lYYTRiTUlIbllHN1paRVBiRSs3bEVI?=
 =?utf-8?B?MWZLNzFlRmhwQytQR1U2d0MydnRjVnVtbW50VDhMV0hrWXY3NEtBY0FYaG9G?=
 =?utf-8?B?ekpxZzhqbzlvUmlYcDVzbUtSUXh6YVJXd3Q3NjBsaUpIWGwxcFMzQ29sM1Y3?=
 =?utf-8?B?bkVkeG5HUjJ5MGRISmUzd28wbU5NRE96WG5yWXU5VEF3THBMVmN3Tktma0x4?=
 =?utf-8?B?aFlkTDFsOFJrZEhhcUdsNXJqd2hBQ25yYmU3RDZoR09xUm1ZdXBLSEViaXRj?=
 =?utf-8?B?QlN2dFpkUzJ6U3k0MnN0QXV3MkE1Q2FrYjVNSkFseGhwdElCNUdpMDU4clJP?=
 =?utf-8?B?NHJNd2t4dTBCdmN1YlRqSTR5SFZYSzBzZkNrMVVsYUl0MHVYUW1qM1p1eUVY?=
 =?utf-8?Q?Ut1nZSgE9RH5FS5wkTHEeoY=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4cdf85-9be4-4bd2-7d78-08d9eb7d117b
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 03:34:24.8099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMEg2uwb96jrQbLnk51Rja8BCLoeYIgaTHcJMput0z5LX8hz0Kpoqz9LrjUn0/P1dseBaukTaIa7KKEG6Unupg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB3025
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Guenter Roeck 於 2022/2/8 下午 11:22 寫道:
> On 2/8/22 03:22, Potin Lai wrote:
>> Add support for passing supported PD rev to TCPM.
>> If "supported-pd-rev" property exist, then return supported_pd_rev as
>> defined value in DTS, otherwise return PD_MAX_REV
>>
>> Example of DTS:
>>
>> fusb302: typec-portc@22 {
>>      compatible = "fcs,fusb302";
>>      reg = <0x22>;
>>      ...
>>      supported-pd-rev=<1>; // PD_REV20
>>      ...
>> };
>>
>
> The new property needs to be documented. However, I am not entirely sure
> I understand why it is needed. Wouldn't the supported PD revision
> be a chip (fusb302) specific constant ? If so, why does it need a
> devicetree property ? I think that needs some additional explanation.
>
> Thanks,
> Guenter
>

My initially intend was adding flexibility for developer to decided 
which PD revision
they want to use for negotiation.

I saw your reply in another patch,  I agree with you, it will be simple 
and consistent if
move "supported-pd-rev" to tcpm fwnode as other capabilities.

Just want to double confirm, is "usb-connector.yaml" right place to put 
documentation
if adding "supported-pd-rev" in fwnode?

Thanks,
Potin

>> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
>> ---
>>   drivers/usb/typec/tcpm/fusb302.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/usb/typec/tcpm/fusb302.c 
>> b/drivers/usb/typec/tcpm/fusb302.c
>> index 72f9001b0792..8cff92d58b96 100644
>> --- a/drivers/usb/typec/tcpm/fusb302.c
>> +++ b/drivers/usb/typec/tcpm/fusb302.c
>> @@ -109,6 +109,9 @@ struct fusb302_chip {
>>       enum typec_cc_status cc2;
>>       u32 snk_pdo[PDO_MAX_OBJECTS];
>>   +    /* supported pd rev */
>> +    u32 supported_pd_rev;
>> +
>>   #ifdef CONFIG_DEBUG_FS
>>       struct dentry *dentry;
>>       /* lock for log buffer access */
>> @@ -1056,6 +1059,13 @@ static int tcpm_pd_transmit(struct tcpc_dev 
>> *dev, enum tcpm_transmit_type type,
>>       return ret;
>>   }
>>   +static u32 tcpm_supported_pd_rev(struct tcpc_dev *dev)
>> +{
>> +    struct fusb302_chip *chip = container_of(dev, struct fusb302_chip,
>> +                         tcpc_dev);
>> +    return chip->supported_pd_rev;
>> +}
>> +
>>   static enum typec_cc_status fusb302_bc_lvl_to_cc(u8 bc_lvl)
>>   {
>>       if (bc_lvl == FUSB_REG_STATUS0_BC_LVL_1230_MAX)
>> @@ -1129,6 +1139,7 @@ static void init_tcpc_dev(struct tcpc_dev 
>> *fusb302_tcpc_dev)
>>       fusb302_tcpc_dev->set_roles = tcpm_set_roles;
>>       fusb302_tcpc_dev->start_toggling = tcpm_start_toggling;
>>       fusb302_tcpc_dev->pd_transmit = tcpm_pd_transmit;
>> +    fusb302_tcpc_dev->supported_pd_rev = tcpm_supported_pd_rev;
>>   }
>>     static const char * const cc_polarity_name[] = {
>> @@ -1683,6 +1694,7 @@ static int fusb302_probe(struct i2c_client 
>> *client,
>>       struct fusb302_chip *chip;
>>       struct i2c_adapter *adapter = client->adapter;
>>       struct device *dev = &client->dev;
>> +    struct device_node *np = dev->of_node;
>>       const char *name;
>>       int ret = 0;
>>   @@ -1756,6 +1768,14 @@ static int fusb302_probe(struct i2c_client 
>> *client,
>>           dev_err(dev, "cannot request IRQ for GPIO Int_N, ret=%d", 
>> ret);
>>           goto tcpm_unregister_port;
>>       }
>> +
>> +    if (of_property_read_u32(np, "supported-pd-rev",
>> +                &chip->supported_pd_rev) < 0) {
>> +        chip->supported_pd_rev = PD_MAX_REV;
>> +    } else if (chip->supported_pd_rev > PD_MAX_REV) {
>> +        chip->supported_pd_rev = PD_MAX_REV;
>> +    }
>
> The else part is also checked in the tcpm code and thus seems
> to be redundant.
>
>> +
>>       enable_irq_wake(chip->gpio_int_n_irq);
>>       i2c_set_clientdata(client, chip);
>

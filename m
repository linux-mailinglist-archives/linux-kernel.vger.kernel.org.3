Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE7251773F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 21:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387082AbiEBTRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 15:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387078AbiEBTRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 15:17:51 -0400
Received: from mail1.bemta31.messagelabs.com (mail1.bemta31.messagelabs.com [67.219.246.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D539DDECF;
        Mon,  2 May 2022 12:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1651518860; i=@lenovo.com;
        bh=Zh7IkU9khBQUNiI+Yavix2ggPTmaSrJrJiecXjwo6RU=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=N+buZ8M4oBhQYdZzYsLlCi1zUHxYrBJq/71rVAon36OMVhxnUo+4wYzXNSQIeLWQf
         lJ98Rl9Jyo/xYAK5QxFrpfl/Ll9AAAGeV+jNirm7CkiHyHCVUP94tlj1XqvYD5seNv
         wHruHbZ71g+BJYf4/e4eW8CjChP1do7r1VsPzQm/kFARhsnZl7ojTbJ2iSQJGjopiP
         UTWFrKzTfLnAfA1thVmZ91XTXY1p0suiI7MCHlpuKx0Cqdfah2AQksa+Zk+etkcGit
         JjXXYuTddSB5RNyFOgKdMDdRZ/b//5tWB/U1DlJwX7Jhwoj91MbHx1JTsw+sR+oIxY
         4IwvzteSiIIhA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNJsWRWlGSWpSXmKPExsWSoS+Vp9utW5B
  k8Pwvj8Wb49OZLNb/XsliMfuwjUX7662MFpd3zWGzmLq7n9XiwNRpzBar97xgduDw+H2A0WPT
  qk42j90LPjN5vN93lc3j8ya5ANYo1sy8pPyKBNaMPcvaWAr2y1a8mBjQwPhRoouRi4NRYCmzx
  LHvSxghnEWsEi1LD0E5nUwSk+fdYwdxhARmMkksOvWHFcLZzyTx5PtGMEdC4DijRPehdUwQmU
  5GiR+vTrFAOP1MEs0rrjFCOI8ZJR4+24jgtF3cwNbFyMnBK2Ar8brrBhOIzSKgIvGm9xcjRFx
  Q4uTMJywgtqhAuET3/v2sILawQJbExJ6jYL3MAuISt57MB+tlE9CW2LLlF1hcRKBQYtaKyWBn
  MAvsZpTYvuY61OmNTBJdJ1vANnAK2ElMX3ScBWKSpkTr9t/sELa8RPPW2cwgtpCAssSv/vNgt
  oSAosSnU8dYIewEieYpRxkhbEmJazcvsEPYshJHz85hgbB9JXYvBanhALJ1JWZPFYQI50icev
  sZqlxO4lTvOaYJjLqzkPw8C8lvs5BcNwvJdQsYWVYxWiYVZaZnlOQmZuboGhoY6Boamuia6hp
  b6CVW6SbqlRbrpiYWl+ga6iWWF+ulFhfrFVfmJuek6OWllmxiBKa0lCJWtR2Mk3p+6h1ilORg
  UhLlrVMrSBLiS8pPqcxILM6ILyrNSS0+xKjBwSFw5eCR2YxSLHn5ealKErzmmkB1gkWp6akVa
  Zk5wLQLUyrBwaMkwssjCJTmLS5IzC3OTIdInWK057iybe9eZo4HJ04CyUuHrgDJa+sX7GMWAp
  sqJc5rrQjUJgDSllGaBzcUlicuMcpKCfMyMjAwCPEUpBblZpagyr9iFOdgVBLm7dAGmsKTmVc
  Ct/sV0FlMQGc1peeCnFWSiJCSamCqYF+3fPXxR0xbq1qmvTz6aZla7taCH++f7zi048vyp35f
  e1iEuPWclFjOr48/fsThS9+7zL8Lrm/9mlj+aMLX0+UqaiwGquFZUQHTr35zdm52n/zic3nNR
  H3pVRr3Xws5/amf3hqtyrG/afp2tR+vtxyNi60876/xbVXLuifPZY9s0HrwjF9U4K2t28HG0s
  Kl/nPrPx+wn6hx/m92SX1zx8LLC2KWXV11x1q7zpSlYP6FtvXiKRvFP65UfeniWM9i6qR8w7/
  IqqH+XktqVnxUfoWe99epYalv7fqiG/1YfyQwJWj5fBd58Nb88KcbfakLVnJ2nDm54ceCLsvZ
  3ZOcBZt3aHG9TPBkvFe4/rm1EktxRqKhFnNRcSIAnjnbtY4EAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-6.tower-706.messagelabs.com!1651518857!35151!1
X-Originating-IP: [104.47.26.110]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17032 invoked from network); 2 May 2022 19:14:18 -0000
Received: from mail-sgaapc01lp2110.outbound.protection.outlook.com (HELO APC01-SG2-obe.outbound.protection.outlook.com) (104.47.26.110)
  by server-6.tower-706.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 2 May 2022 19:14:18 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9sDdZ25FvrwIcPoVY7MO3r0P6SPYEP636BsAjrBzugvL+RiptjgipLARlJ5DAWNTdw9NWAt/kr26pVe0z2VSpwWnfmxU7H6DO+S4+e91Hxbjjc6aidxUBMCX+AmFb8u/DOYsFgSp5ZhQkfU6CWdHkQYAiDicZ2tUkLOTvDffs7MIHAW5rlHS0uWMvplcs9yAyW7ooBDqZ41POZyqA17OtGkyv1/52KHp+qQzqkpmJ4Ko28eHY4sL1JhuZypwGxRErut4u9NPfTnh8qo0BPjF3Z29xnavbNYV9hkUqSWGcJjnREyICPRj9BGU2LF3bR9jL1m2B/DSABkKURRY0ahZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zh7IkU9khBQUNiI+Yavix2ggPTmaSrJrJiecXjwo6RU=;
 b=Ob7YPujUQJY0BwFWGyRriXpxLMQbu7KYIQClqJxhLmE9avbT5AXE5SQPe22QLy3UMNY6Um0f26eONbMrI3ldUBpykLibZWFlgu+Qnq6tZm4tflODJ4fmlL/mD5J9+WxMb/K3nvjv3svutWVBeaVgJ7nt7ynM8Sdf4VZZ4V1gnIijRQNqarCQKICE1G4d6j6BlgeihTGfOUiihdJH4F1/gUCBreCwkh0lOx7ZbIFIipxQpcKdLSi07CAsQ9Dd1WVsDrj8k28mBE3HK7BBcp4sFMm0uf6gADb0sYqUvdS0a/naGdJSS9uC04rkf99jMigSbk4oi+XdKqddAx7sQTsZBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.232.225.7) smtp.rcpttodomain=redhat.com smtp.mailfrom=lenovo.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=lenovo.com;
 dkim=none (message not signed); arc=none
Received: from SG2PR06CA0227.apcprd06.prod.outlook.com (2603:1096:4:68::35) by
 SG2PR03MB4568.apcprd03.prod.outlook.com (2603:1096:4:85::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Mon, 2 May 2022 19:14:16 +0000
Received: from SG2APC01FT0030.eop-APC01.prod.protection.outlook.com
 (2603:1096:4:68:cafe::e2) by SG2PR06CA0227.outlook.office365.com
 (2603:1096:4:68::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Mon, 2 May 2022 19:14:16 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.232.225.7) smtp.mailfrom=lenovo.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=lenovo.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 lenovo.com discourages use of 104.232.225.7 as permitted sender)
Received: from mail.lenovo.com (104.232.225.7) by
 SG2APC01FT0030.mail.protection.outlook.com (10.13.37.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.12 via Frontend Transport; Mon, 2 May 2022 19:14:15 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Mon, 2 May
 2022 15:13:58 -0400
Received: from [10.38.104.132] (10.38.104.132) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Mon, 2 May
 2022 15:15:03 -0400
Message-ID: <24fdaa0c-5f63-5e81-5f7c-cd439d301f8c@lenovo.com>
Date:   Mon, 2 May 2022 15:13:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [External] [PATCH 1/2] platform/x86: thinkpad_acpi: Restore X1
 Carbon 9th Gen dual fan quirk
Content-Language: en-US
From:   Mark Pearson <markpearson@lenovo.com>
To:     Lyude Paul <lyude@redhat.com>,
        <ibm-acpi-devel@lists.sourceforge.net>,
        <platform-driver-x86@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <markgross@kernel.org>
References: <20220429211418.4546-1-lyude@redhat.com>
 <20220429211418.4546-2-lyude@redhat.com>
 <d3461670-a905-4956-4f4d-d847adf4289b@lenovo.com>
 <2769588a352e9c3b43a4e09afff100d52a9ba524.camel@redhat.com>
 <d7a35afb-6b3a-7d76-0dc1-975842407fea@lenovo.com>
In-Reply-To: <d7a35afb-6b3a-7d76-0dc1-975842407fea@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.38.104.132]
X-ClientProxiedBy: reswpmail01.lenovo.com (10.62.32.20) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2faf0db6-8738-4ba9-7819-08da2c6ff362
X-MS-TrafficTypeDiagnostic: SG2PR03MB4568:EE_
X-Microsoft-Antispam-PRVS: <SG2PR03MB4568A02B846765978DA1D0E5C5C19@SG2PR03MB4568.apcprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r7mIcKZNtuXBh/abq/tTpkJnGVLjVn5QWJb4THS/Avqm1OTK2xSdbJCbknEWq0p2xyNAhONsXr674IZu6Wz+KdS6i5R6ziu0zDIuHEkzfLK0tdyeY9RPD03URDRzN2N9LBSSyixzVwjcbhUfNMby3P0gourGjIv7sBxW2xt1G2pRm86AaS0LlIlLqGZjwB/OnzbDhQqTNNU7SifzfQPpb6n2ysg/6nGcIbZWwsKZRBWpmzN3Ba3ehaKHn91Gb29MZqMkrtrUgRbGZfrCAGT8FQ8uO7Lk40MBnlsPmNyeAGhnISVLzaMwsruvEb6YCJfFGAtXEsLt87dirSNqHnw05a0E4xlrreXQNy4gyGIGJ2BqbVHh6BSVeBFE8Gier0orbPgperWwER9+hzIzet3lfgv4agyj974C1YoSabkDqZZ/baI5860WMMad69vE2UIwGXqMyJ0BszIXV7ymcx5YJBdo7ABY66qCAshnnhVgLhQpdwEQiY+9yqp4MjiZRrG+v53ixUlM6XQ5xUGbbhBxrbIEZsB7DfzmB2DqwWcmW1Gr1YhQ7d6f7zTB72x7Gi/rREKJHE/nimstYk8Iie9t/6twTE+J0qauIw+61QbNNE2HkPeHaC67L1cTC7TQrSOEzrVorHaFaYNpj7Hxk31LJClx558vMWIsulEZQ1rDyQqx/7GxXvah/G8AvO2jTGyL+IM1vhtenm8bftVG5VBs4V3O4YUsQjxw/55Na7iapHPHA5oOHxbgRKwF+qrOs5GjenSXY7kuFliAshG/Kx6SNg9WLYlvUbXbSIjzJjxxQ0KwB/doyvd9PGbdfTRUMvpR
X-Forefront-Antispam-Report: CIP:104.232.225.7;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(356005)(70586007)(70206006)(81166007)(8936002)(36906005)(16576012)(54906003)(86362001)(31696002)(40460700003)(110136005)(5660300002)(36860700001)(53546011)(426003)(2906002)(316002)(47076005)(508600001)(2616005)(6666004)(16526019)(336012)(186003)(83380400001)(82960400001)(31686004)(8676002)(82310400005)(36756003)(26005)(4326008)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 19:14:15.7499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2faf0db6-8738-4ba9-7819-08da2c6ff362
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.7];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT0030.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB4568
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/22 13:44, Mark Pearson wrote:
> 
> 
> On 5/2/22 13:42, Lyude Paul wrote:
>> Some answers/comments down below
>>
>> On Fri, 2022-04-29 at 21:25 -0400, Mark Pearson wrote:
>>> Hi Lyude
>>>
>>> On 4/29/22 17:14, Lyude Paul wrote:
>>>> The new method of probing dual fan support introduced in:
>>>>
>>>> bf779aaf56ea ("platform/x86: thinkpad_acpi: Add dual fan probe")
>>>>
>>>> While this commit says this works on the X1 Carbon 9th Gen, it actually
>>>> just results in hiding the second fan on my local machine. Additionally,
>>>> I'm fairly sure this machine powers on quite often without either of the
>>>> two fans spinning.
>>>>
>>>> So let's fix this by adding back the dual fan quirk for the X1 Carbon 9th
>>>> Gen.
>>>>
>>>> Signed-off-by: Lyude Paul <lyude@redhat.com>
>>>> Fixes: bf779aaf56ea ("platform/x86: thinkpad_acpi: Add dual fan probe")
>>>> Cc: Mark Pearson <markpearson@lenovo.com>
>>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>>> Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
>>>> Cc: Mark Gross <markgross@kernel.org>
>>>> Cc: ibm-acpi-devel@lists.sourceforge.net
>>>> Cc: platform-driver-x86@vger.kernel.org
>>>> ---
>>>>  drivers/platform/x86/thinkpad_acpi.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/platform/x86/thinkpad_acpi.c
>>>> b/drivers/platform/x86/thinkpad_acpi.c
>>>> index c568fae56db2..9067fd0a945c 100644
>>>> --- a/drivers/platform/x86/thinkpad_acpi.c
>>>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>>>> @@ -8699,6 +8699,7 @@ static const struct tpacpi_quirk fan_quirk_table[]
>>>> __initconst = {
>>>>         TPACPI_Q_LNV3('N', '2', 'E', TPACPI_FAN_2CTL),  /* P1 / X1 Extreme
>>>> (1st gen) */
>>>>         TPACPI_Q_LNV3('N', '2', 'O', TPACPI_FAN_2CTL),  /* P1 / X1 Extreme
>>>> (2nd gen) */
>>>>         TPACPI_Q_LNV3('N', '3', '0', TPACPI_FAN_2CTL),  /* P15 (1st gen) /
>>>> P15v (1st gen) */
>>>> +       TPACPI_Q_LNV3('N', '3', '2', TPACPI_FAN_2CTL),  /* X1 Carbon (9th
>>>> gen) */
>>>>         TPACPI_Q_LNV3('N', '3', '7', TPACPI_FAN_2CTL),  /* T15g (2nd gen)
>>>> */
>>>>         TPACPI_Q_LNV3('N', '1', 'O', TPACPI_FAN_NOFAN), /* X1 Tablet (2nd
>>>> gen) */
>>>>  };
>>> I just double checked this on my X1C9 - and it's working correctly. 2nd
>>> fan is detected correctly.
>>>
>>> I'd rather understand why it's not working on your setup then just
>>> re-introduce the quirk.
>>
>> Of course! I figured as much, it's just easy to start conversations with a
>> revert :P
>>
>>>
>>> What happens on your system when the
>>>   res = fan2_get_speed(&speed);
>>> is called? If that is failing it means your 2nd fan isn't responding and
>>> that's not supposed to happen. Could you let me know if you get an error
>>> code, if it happens every boot, etc
>>> I assume when the function is called later it works successfully?
>>
>> It definitely seems to happen every boot, not sure about the error code it
>> returns. I will check and get you this info asap
>>
>>>
>>> Also please confirm which BIOS and EC version you have.
>>
>> BIOS version N32ET75W (1.51) release date 12/02/2021, embedded controller is
>> 0.1.32
>>
>>
> Thanks!
> 
> Along with Thomas' notes I think I've found the problem (though still
> bemused why I don't see the problem on my X1C9 and I tested on multiple
> platforms previously...so it is somewhat weird).
> 
> Working on a fix - will try and have that out for review later today or
> tomorrow.
> 
Not sure exactly what the etiquette here is for the mailing list but I
just posted an updated patch "platform/x86: thinkpad_acpi: Correct dual
fan probe" that I think addresses all the issues raised in this patch
sequence.

Please let me know any feedback or concerns. And thanks for raising this!

Mark

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8838596B4F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiHQI0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbiHQIZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:25:36 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2053.outbound.protection.outlook.com [40.107.105.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DEB78208
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:25:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVE5d+duYK6qMJiR+HmPh+WG9PhKW2lk95KwUQtCvsSq8SwzPFeBi/AzlK5eiSYTW6kZWL+B+Mw3xc7X46SKVTG+LoSllVBzaxDWLp1sMjwAS1b7bpgADaORpl5B01DIu3OFsT1a00K3wvQKP+uT8fSYRBy1nRyD2RRnKzco1SHHwQFUw2rqwFUNNUpoxnVUNE3Ctyeng2sAiVQxiELGMHwh6UOrdfiuKb76RTl3MKxdWspdhfmOnepo4ftBA5wW8Ve3OyNXfZnqDHMO7OIPSS84I8hZo4GeWZ8/0sEASIMXJBOMUuZD3Aur7hQVFB5h1m9kCA9shh0E2bk9Q0X49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJKGFfPBzwMYQagWwIMnsQET+AnPFF5JiUdptd67fUs=;
 b=ji6rbu5usn9mLSQvDHgPndOSsaXSKxG0CrPBDz/KMBcvKk8MA7a0m8j8BiC46pxE1Oky6LlcIWPaPQbwe1BWwF/3ztUMtzNoBxBanP4muVYElI35hAK1tzo8vWqEUIw0lWXOl4K/kF6RGPNr5cd7dnFz357IK7zAPEBggO1kcTleXF2XSuV1UAWH+00BYeqTLKGFbcd1sJ8j86+9+4Kt4JRKJ0gSDYhJj1ydvdowwy4GhtChijvAtU3GJOn6sQUkAO/6nCHAAzfw6PBm/BUiEkcz1c+LwYTG8GxsxPYQ2PQFpUM630ls1VkYDREDzO8FpOgq/d5qoFURW/8lUdt+nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJKGFfPBzwMYQagWwIMnsQET+AnPFF5JiUdptd67fUs=;
 b=jJEZAp9ysCEPjmxXgY1G679tKEOJjYE64l2E6mGf0xnt3OG6Nigu92H6LkrU2cWaFcqeFFe8MQtONaNmjzQhBnsZfbQMxWX5XXFdN5ltdbqlvsp6Y1tfXhqCBUg8Ti71Nhu7rAJw03IUpp/+RtPrvDMs0yDbN2uo6JVbBuO97g8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22) by AM0PR08MB4354.eurprd08.prod.outlook.com
 (2603:10a6:208:13e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 17 Aug
 2022 08:25:31 +0000
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::dcaa:905c:ff8:1f5b]) by AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::dcaa:905c:ff8:1f5b%9]) with mapi id 15.20.5525.010; Wed, 17 Aug 2022
 08:25:31 +0000
Message-ID: <88e9c256-b930-d26d-63b4-9d0f132ae962@wolfvision.net>
Date:   Wed, 17 Aug 2022 10:25:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [BUG BISECT] phy: rockchip-inno-usb2: Sync initial otg state
Content-Language: en-US
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Markus Reichl <m.reichl@fivetechno.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220622003140.30365-1-pgwipeout@gmail.com>
 <88f2de00-32e3-ed74-082f-c0972a81f0f8@fivetechno.de>
 <CAMdYzYoTLjRW1FgwfizUu-+k0R4tCO78qYa7MEpgfz99aj3SvQ@mail.gmail.com>
 <ec3d2515-b2a2-8441-2e9a-a7fe664e048a@wolfvision.net>
 <CAMdYzYo1nm76ti3PCYk4DYtEnjWD731bybHaQV3ODBZi4SMvRg@mail.gmail.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <CAMdYzYo1nm76ti3PCYk4DYtEnjWD731bybHaQV3ODBZi4SMvRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR10CA0117.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::46) To AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 612f0e4c-cfbf-4198-40f5-08da802a0c5a
X-MS-TrafficTypeDiagnostic: AM0PR08MB4354:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4i0BScIQKhQTi5wsQ2uWLFwvmuwlkyDqPwS0G88TFnmD09HWJUstgNaJa6RiuflKREI8Et6lubaw5JgzZ5vT26uud2FZIcwYaimzdG4FB/K9uTscwTWkvpQ3hiXLffIkcZu8eYdlVr8U40BjoJhEIy4KFniFStJ6/uKvy9zE4PHrG/BQXEY/0bHpb7HUNI3iWOU+Eg1QElb10jsHsF3zQk5hGcmnsNhiWb1uU5Ta6styf8cBgXSLDdqB5IHXyI/9ZkqG3UtK9uh/W5W38LhZDurnZ1Z+eZrfBFaAvLEjr3X7qMLhPfe6M62bcLxm/nYiIJoH4Daej6xK168yzjmsv6LERyi/KLDPRAM2tWeWQAaBNJKd1jRe1EEEVsfttbklZzYtw4juljIgeGTSur9YuUpnw5oL/kFpMnVxxqFKTHVEDiPPekUeI53zm3B6IVwFnX6wADoHgkJ5IxYuzDqeMVV8hDGyFzi1JoYxvjTZkgexQnWgCBx8lvpkoRNt4NonBMDbHWiIkSfwN+6VNTQP7LQwWfU+dMVlGwa4/sEHXv5jr9OJus0v4ZgYlaAdKGlAulxnqfzlOFwpY/OjMZg3skIo9ZS63poVluYKDwcjfpGUvwKFeID6ALoojACfzHYPnsrEiqDkxkUN22qmE2kawmBV0/KuDenv+W9YjUYhIw+fW3rvHHFCpXN9BBH4J7IR7vOO32GYgASx16k05+hp91SYMlOJXECUErRVp/0AN2yaTFSKOC1cR06lhpwzwL74ptrc+F6DpwXsT7b7+ZvG9Ahm9/PM+nVQmWqX3POtLbxYAB0jNvaO8Sgc7tzp9cRxLdd3Q760EQqz0/akRs7GhONMbN3GTdD8wZhc0VLjlYGltfI1tq76/6U7Vb+e/j0MTPijkKRjP6yczjY7UoncQNHbkp4+0bxuUCJP4j9xEeg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0802MB2131.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(366004)(396003)(136003)(376002)(346002)(5660300002)(6512007)(36916002)(26005)(53546011)(478600001)(41300700001)(6486002)(6506007)(83380400001)(52116002)(2616005)(966005)(186003)(44832011)(2906002)(8936002)(7416002)(54906003)(6916009)(8676002)(45080400002)(4326008)(66476007)(66556008)(66946007)(316002)(38350700002)(38100700002)(36756003)(31686004)(31696002)(86362001)(10126625003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE1FQ21wTk9XaDVKSFZCTlVDVTRQM1lieXEzUzhwQWJ0Yi9aT1hQVUFXN0NN?=
 =?utf-8?B?Z2RiWlBQQmhRY0ZHT0RqV2dzdzVXNkYydlRYbnRnVzNWdTNhNytXOHdKQmRs?=
 =?utf-8?B?R0lFUVYxNGRsRSs5YWhRYjc0VDBsY0J2WmRGN2dlWkNUMEM5Sk1aWXBHVmhi?=
 =?utf-8?B?bmljdStLQXA1RVYxNTcwMmNxclRBUld5STNDdi91L3Q4anM4cDhRVkFQdnZK?=
 =?utf-8?B?aThhbk5VdzBmYXkzVlhmWUhNSGdQMVU0UnJBeC94VVR1TWVjZEJteVQ3bWVn?=
 =?utf-8?B?d0VOOWZhT0h0N1FBS2oxVFZUeGN0Z1RzR0ozMEV3ZXpCT2VodktmVTRNTlNZ?=
 =?utf-8?B?bE9NcmUvMWd5RkFvQS8zOE1HbGFnWDdPTEFsTXl4dGduejFrRkFDekE4ankw?=
 =?utf-8?B?Zm9vZlJGSStRZXRtNjZWcVN1b2xmaDZqMlUzOVZPa0J5STFxY0ZCY0dnSFFs?=
 =?utf-8?B?U1dwOG5iRzlyTUJ3SktucytrRllUeG9YTEs4MVBKQ3V4bjlDWWtPMzZ1ZWsw?=
 =?utf-8?B?eTN6WVMzSE96UXluL2wzK3JMVTNLU25PSVpXUkpVZ0FQTjh6Qld6Y3lVMlp0?=
 =?utf-8?B?WkRleVg2c09yV05hcUFoVVgwQXV4ZGRrZVNTWXNudmJZY0pKcUxBVVJNTytl?=
 =?utf-8?B?Ly8rQnlkUng4NlhqVEZxSkNDY21CN09WN2JUNjVic2kxSU1UMnlSZlVjakJB?=
 =?utf-8?B?QTFhc1JuMDA0OW5oMEVLZHhvZ2Q4RHVwaFBMRXdYYmZzOUUrT09wTWk1TDBq?=
 =?utf-8?B?QzZubE5jc1U2SXB2RlY2MjE3L1VCalI2RVNtNmRsN2haOXZhK2NsTnMxM0dC?=
 =?utf-8?B?UCtQN0Q0a3ZWUXFFUnE3TjJsNUhqMlVjQ05OeWVZU0JLbUkrMEhlQUR5dFhM?=
 =?utf-8?B?WFZJYWJuZk9wSmRncWRHRTdKOGtsbHRQeGxjSzF3VTAyRkFpOWtrZmtQMDBr?=
 =?utf-8?B?U1B4Z3FhT3piVjlYeWRTRDhlTzluVXNsOE1TK01xVXFqQS9rVmVrVGVDQkV6?=
 =?utf-8?B?SE9MQkZ4N1BHYkgwQVB6L0ZsWGZmOG15NGRXTUtrWHlrcE5GWVJMMUpJOGpy?=
 =?utf-8?B?bkZGVUxQYmpWeTFNVXljTWVCTUFkQytGZXlGSmhXRFBaSS9Eck1WLzZ0ZHlj?=
 =?utf-8?B?WjdsWXZSOHVZOTBpWjNZNEF0SU5sOVN6WHRTbEsrTVdWY0ZMZFVFbVRSL25Z?=
 =?utf-8?B?R1dhc3J6N3psSlp5WlBXcDc1dlVmRUNud0tFRGF4ek1abGxtSFhtSU03MDhm?=
 =?utf-8?B?cVd5RXBUSEkzVHJROEUxenU3RjVLZ2o1OVpkcjhOMWlyRy9kYlNZSEExSDFK?=
 =?utf-8?B?Y0VjRDlwTUFPNnRTalBFbDNmTGJFSkRCQUlWeU1RRUovSmNTb2Vrc3ZJVkw4?=
 =?utf-8?B?YUdQQzI4S0lGbHdQLzJRL00yZFIvenZJNjV1dTdCNE45SWtMS3BYQldxTHRS?=
 =?utf-8?B?ZDNYOVliUUM3ZG9pZ3FMeHVxWm9QQlpJeHJveGdtZmpNV2M0SmtuOXI4MjFY?=
 =?utf-8?B?UTB1TUxZZGJGa1V1TS9JeTBzRU1NTXIwUm1Ickp4R3o0WHFtRER4cWc5QUR0?=
 =?utf-8?B?d3g3Tk8zeWI4bm1jWmZlQkVTTFZtd2pJRDlkOUVOelJzVC84azJWakViZ1lK?=
 =?utf-8?B?T2xkbThDcjlBNi9CcTZmYVIxMWQvRHFkSzMvOWNScld3MExScHRkRkVleExo?=
 =?utf-8?B?UlNxSHFVQ3RqQmVYVUJoWVhrd3pOdVJhR1d2eWlodTIvK3NxWXdicjF6bHpq?=
 =?utf-8?B?NlFBSnMrUUppM0pndzgyQWc3QnBJT3FSd0hkbVdhNDlROHdjRlQ2a21mc1Ri?=
 =?utf-8?B?bVpHZjQ3TGw3TDIvREdVd1NWMGtZRmJ2M09DS2Y3V0xWVzJ6ZVNvZ2JNZTdN?=
 =?utf-8?B?QVhBTU84Zk0yaW53bDYxYkxZZVcvS1ZqWnl0d2FsazFyRHI0Z0tMS2w5TEFj?=
 =?utf-8?B?TVMxZkZYWnFDeFBJaEp2clZmOVJuc0lSTG80emdOb1A2UHhTdmFBT1l4cDEw?=
 =?utf-8?B?d3dnYml0eDBzaUhETmpBbmJocmdMamRxYnlmU25nVTAzczV0ZUJOUmV5aFda?=
 =?utf-8?B?MzAyTDdvcytBN3RmVUw4Z0JTem1pT2pUcHlGREhnRDVzdnphZFczb1RGcUNX?=
 =?utf-8?B?UjVFa3NIUHRWa3BLQlpkRi95eFlSa0JzS3dRMHJmRjlvU2JBQzNJYmRCTHNK?=
 =?utf-8?B?MkE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 612f0e4c-cfbf-4198-40f5-08da802a0c5a
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0802MB2131.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 08:25:31.1663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBixlhtBo3zlHu1huYAhqWoFRt9D4Ri2kZbJf6zAqPeAGAaf+1hxDwokDy6vxTY5qMfwHgM0NbRex1lqIQekr3T3o+LEQRcXv3Q3IkmBlRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4354
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 8/16/22 17:27, Peter Geis wrote:
> On Tue, Aug 16, 2022 at 11:20 AM Michael Riesch
> <michael.riesch@wolfvision.net> wrote:
>>
>> Hi all,
>>
>> On 8/4/22 11:49, Peter Geis wrote:
>>> On Tue, Aug 2, 2022 at 2:39 PM Markus Reichl <m.reichl@fivetechno.de> wrote:
>>>>
>>>> Hi,
>>>>
>>>> with linux-next-20220728 rk3399-roc-pc does not boot.
>>>> Bisecting pointed to this commit.
>>>> By reverting this commit the board boots again.
>>>
>>> Thank you for reporting this, someone was kind enough to reproduce the
>>> problem on the rockpro64 and confirmed this is an issue. As I won't
>>> have access to my hardware until next month, we should probably revert
>>> this until the root cause can be identified.
>>
>> Just experienced this issue on my ROCK3 Model A board (RK3568) and
>> reverting this commit solved it.
>>
>> Having the revert in v6.0-rc2 would be great -- if there is anything I
>> can help to accelerate this please let me know.
> 
> If this is now happening on rk356x where I know it works, it now
> cements my theory that it's a symptom and not the actual problem.
> Possibly a race condition with the grf and regmap code where it isn't
> quite ready when called. This code path is called exactly the same way
> later on when the irq fires.
> 
> What config are you based on? I'm running a stripped down version of
> the arm64_defconfig, but if you deviate from that it will be helpful
> in reproducing the issue.

I posted my Kconfig here: https://pastebin.com/P1As0W4k

FWIW the ROCK3 board has a switch to set the OTG port to device or host,
respectively. The NPE does not occur when the switch is set to host.

Best regards,
Michael

> We should revert it until it's isolated, as well as the patch setting
> the rk356x to otg since it will again be broken. If someone could
> weigh in here as well (I currently don't have access to my hardware)
> it would be helpful.
> 
>>
>> Thanks and best regards,
>> Michael
>>
>>>
>>> Very Respectfully,
>>> Peter Geis
>>>
>>>>
>>>> [    2.398700] Unable to handle kernel NULL pointer dereference at virtual address
>>>> 0000000000000008
>>>> [    2.399517] Mem abort info:
>>>> [    2.399772]   ESR = 0x0000000096000004
>>>> [    2.400114]   EC = 0x25: DABT (current EL), IL = 32 bits
>>>> [    2.400594]   SET = 0, FnV = 0
>>>> [    2.400873]   EA = 0, S1PTW = 0
>>>> [    2.401161]   FSC = 0x04: level 0 translation fault
>>>> [    2.401602] Data abort info:
>>>> [    2.401864]   ISV = 0, ISS = 0x00000004
>>>> [    2.402212]   CM = 0, WnR = 0
>>>> [    2.402484] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000001376000
>>>> [    2.403071] [0000000000000008] pgd=0000000000000000, p4d=0000000000000000
>>>> [    2.403687] Internal error: Oops: 96000004 [#1] SMP
>>>> [    2.404130] Modules linked in: ip_tables x_tables ipv6 xhci_plat_hcd xhci_hcd
>>>> dwc3 rockchipdrm drm_cma_helper analogix_dp dw_hdmi realtek drm_display_helper
>>>> dwc3_of_simple dw_mipi_dsi ehci_platform ohci_platform ohci_hcd ehci_hcd
>>>> drm_kms_helper dwmac_rk syscopyarea sysfillrect stmmac_platform sysimgblt
>>>> fb_sys_fops usbcore stmmac pcs_xpcs drm phylink drm_panel_orientation_quirks
>>>> [    2.407155] CPU: 4 PID: 71 Comm: kworker/4:6 Not tainted
>>>> 5.19.0-rc8-next-20220728 #437
>>>> [    2.407868] Hardware name: Firefly ROC-RK3399-PC Mezzanine Board (DT)
>>>> [    2.408448] Workqueue: events rockchip_usb2phy_otg_sm_work
>>>> [    2.408958] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>> [    2.411634] pc : rockchip_usb2phy_otg_sm_work+0x50/0x330
>>>> [    2.414332] lr : process_one_work+0x1d8/0x380
>>>> [    2.416948] sp : ffff800009373d60
>>>> [    2.419406] x29: ffff800009373d60 x28: 0000000000000000 x27: 0000000000000000
>>>> [    2.422199] x26: ffff0000f779fcb8 x25: ffff0000f77a3a05 x24: 000000000000000c
>>>> [    2.424978] x23: 0000000000000000 x22: ffff0000010c8258 x21: ffff80000888ec10
>>>> [    2.427768] x20: ffff0000010c82f0 x19: 000000000000000c x18: 0000000000000001
>>>> [    2.430604] x17: 000000040044ffff x16: 00400034b5503510 x15: 0000000000000000
>>>> [    2.433390] x14: ffff000000708000 x13: ffff8000eec96000 x12: 0000000034d4d91d
>>>> [    2.436185] x11: 0000000000000000 x10: 0000000000000a10 x9 : ffff000001aa7a74
>>>> [    2.438958] x8 : fefefefefefefeff x7 : 0000000000000018 x6 : ffff000001aa7a74
>>>> [    2.441668] x5 : 000073746e657665 x4 : 000000000000002f x3 : ffff00000356c808
>>>> [    2.444407] x2 : ffff800009373da4 x1 : 000000000000e2ac x0 : ffff80000888eb34
>>>> [    2.447190] Call trace:
>>>> [    2.449557]  rockchip_usb2phy_otg_sm_work+0x50/0x330
>>>> [    2.452169]  process_one_work+0x1d8/0x380
>>>> [    2.454684]  worker_thread+0x170/0x4e0
>>>> [    2.457056]  kthread+0xd8/0xdc
>>>> [    2.459354]  ret_from_fork+0x10/0x20
>>>> [    2.461728] Code: 91037015 295be001 f9403c77 b940e413 (f94006e0)
>>>> [    2.464338] ---[ end trace 0000000000000000 ]---
>>>>
>>>> Am 22.06.22 um 02:31 schrieb Peter Geis:
>>>>> The initial otg state for the phy defaults to device mode. The actual
>>>>> state isn't detected until an ID IRQ fires. Fix this by syncing the ID
>>>>> state during initialization.
>>>>>
>>>>> Fixes: 51a9b2c03dd3 ("phy: rockchip-inno-usb2: Handle ID IRQ")
>>>>> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
>>>>> ---
>>>>>   drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 6 ++++++
>>>>>   1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>>>>> index 6711659f727c..6e44069617df 100644
>>>>> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>>>>> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>>>>> @@ -1162,6 +1162,12 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
>>>>>                                       EXTCON_USB_HOST, &rport->event_nb);
>>>>>               if (ret)
>>>>>                       dev_err(rphy->dev, "register USB HOST notifier failed\n");
>>>>> +
>>>>> +             if (!of_property_read_bool(rphy->dev->of_node, "extcon")) {
>>>>> +                     /* do initial sync of usb state */
>>>>> +                     ret = property_enabled(rphy->grf, &rport->port_cfg->utmi_id);
>>>>> +                     extcon_set_state_sync(rphy->edev, EXTCON_USB_HOST, !ret);
>>>>> +             }
>>>>>       }
>>>>>
>>>>>   out:
>>>>
>>>> Gruß,
>>>> --
>>>> Markus Reichl
>>>
>>> _______________________________________________
>>> Linux-rockchip mailing list
>>> Linux-rockchip@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip

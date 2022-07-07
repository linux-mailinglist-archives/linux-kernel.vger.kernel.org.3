Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCC1569A8D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiGGGe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGGGeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:34:23 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60102.outbound.protection.outlook.com [40.107.6.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C55167F6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 23:34:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPjgdGhY5cW7lBosKdmlY5RL5cUO3qsIE8H2SoCuUSKq6TDv0xfbZST3UzuGQ2VszBsCZxNgTmDByEg1oxhwO4Bs4FTMDxyluHBAHDwCxIJ5law2ItV6r64o8GtNANqVmv/rD6nq0a7d11xG14ORW/px1ZTPymM3xJdBKhFB9DyHdvhd5brpQJbPMuHmI+vJYkJs2iHSlBm7qN0laf71WmwU/hqB8GhPjkXREnXSbK/S5dMzjF2jDBTbjG9sgI1QWFt9RU57aG/dxQykRbvIhT3kzAzE7OMHyzHMOsOvm+bLbjEnQBJP/UivkkWQvYbSFPEKjcYJPcaJ8IdEwQYwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUnjek3lY8LEyEa12E6wxdOKb8n+NQn4ex23oKcOPsk=;
 b=KHEovEPSklXrrcRWtqpUePz6mTerefFxnTWj5HagVTdKUqYdH1vbS6JrTislDU76gMo++BxOwHduaRKSjfPQLg+plDw0bzDVGwxVDYMJvkEk+sRIoP8bQ6AuyBvGYKWSaJJv2qYncFqAlkPWInGwY/vIOGu/OcJ/zX9VmHx1GNpH0+X0L57l4FzNpMPE75YvismejYjS/YSqVBJyAmmXuRzR6Hr7VMYWS2bvQqBx4mScOgMlagqWKMpzLbLzx16E5+w25mxFqPytOdMAm/cHsHV3pP+b51/uQYrIJRCimsUSKmDfHUifRW0YM0Q7j2EUqmc+7qlxJCJlef9kY7DtfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUnjek3lY8LEyEa12E6wxdOKb8n+NQn4ex23oKcOPsk=;
 b=M5cyNIzWlJ2cBeLMA0BlDsuV7mJ3jguq6ED1TcpjkSvuactoBRHZgBgValJerDivJUyi7TM8YeUMSc5tnFymrNG3Uyy+qp/WFFuFq/PCJ1EXQtTUCsZWUqluSZsedIgYDq9r1fYjqi+IKyelttoXnt/f4e9HDWjksnn2cfPKgp4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AS4PR07MB8658.eurprd07.prod.outlook.com (2603:10a6:20b:4cd::12)
 by HE1PR07MB4250.eurprd07.prod.outlook.com (2603:10a6:7:95::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.6; Thu, 7 Jul
 2022 06:34:19 +0000
Received: from AS4PR07MB8658.eurprd07.prod.outlook.com
 ([fe80::c563:c1cf:c12:fe3]) by AS4PR07MB8658.eurprd07.prod.outlook.com
 ([fe80::c563:c1cf:c12:fe3%7]) with mapi id 15.20.5438.005; Thu, 7 Jul 2022
 06:34:19 +0000
Message-ID: <2bb016da-363d-5aac-fe7c-066cfe52d738@nokia.com>
Date:   Thu, 7 Jul 2022 08:34:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ARM: module: Teach unwinder about PLTs
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Kursad Oney <kursad.oney@broadcom.com>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
References: <20220706163135.53874-1-alexander.sverdlin@nokia.com>
 <29684681-2f0f-e887-20d9-dddda4977512@gmail.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
In-Reply-To: <29684681-2f0f-e887-20d9-dddda4977512@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::9) To AS4PR07MB8658.eurprd07.prod.outlook.com
 (2603:10a6:20b:4cd::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e93158da-5db0-4c60-8d77-08da5fe2b8c2
X-MS-TrafficTypeDiagnostic: HE1PR07MB4250:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4HkKQ7XPvBKmHKY92RC70jzx7dStyWoF6QazBxFytPodiVX9gEXoFkDCMz8ONsfBb8LXfXwX8f7vUd4AVkmOgIXtz3PCdH/TPFJHCE3jcRaia6N4xYB8GkCNqTZtdfPrQgH5nL7FTfvJ/Y9NWMb4XD052pKQ3lhQNFp0niI5Wx5Or+/DKmw15VpINRg2uJ59UIlfcGwFixsdeO9e8PaJG5P4Wi04M+KpBGkcmqO0yyQMAkBcDAu7W0oJDOKxTwlGkwK/NNMH/1mGB+eb476R36wpwraNS4U/N03BBJtC09OMQMR42cX3jzsdwsI68kYeOCok/mFYNfJa15CckFrR34VqIa5bct61YRJQseY/LYJ+3PJePBofIoQq5hLW0aMTOIZuqD8KVG6rByR/DaeQE//k70rHlrEyuMbX84X7pp9bkcZkbCjmHHDIuKnPB8VKeG8qsGqgpTSbywS0+w355f0jTJLy9W/8uUDaf/X+N3BWzF2KvIgNT4fFRUBYTe58Svr2NaLMRVoMp/jzKQN4pa4+GLq4J9/NI8yA8V6zntp/PLcMS2ByeB/YWbqCBWO8occH/WsdDNBXCutrOMm+TXthibzJJ2L+gZHS+LKi76peJUM1+8swlIrKY89DobJGJ4N8MPizHe2Y7GQSWZxvggDfVTDS298LHQO0c9Ga6h2iwPIX+HLrjrEhNDUeF3lFVxX9MWODb/SGk6yMCgX4JrmgGRC7UG02wdqw7p55Ms0kmFgCNizKwGard/ZutuKEzaH0P/XvJGQu9hs7yyNXCfV9ed8Y5V267BW4u4FCDhJEvhVySQcxBuMXRyZt7/JHNq8f0atbnSr77vMaepK+CiYdn+L+jN5ixxywgIDN+EiF356JEQqYeVMcv51QXBWC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR07MB8658.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(966005)(6666004)(38100700002)(478600001)(6486002)(66556008)(2616005)(186003)(4326008)(2906002)(31686004)(41300700001)(36756003)(53546011)(6506007)(54906003)(31696002)(316002)(8936002)(5660300002)(82960400001)(26005)(86362001)(6512007)(44832011)(66946007)(8676002)(83380400001)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXFhSUNEdkc5OTBTM1gydFhFbVE2bVNuVWNzNFVVcEh1VjlYZFFhYUswNDBw?=
 =?utf-8?B?T0dMd3FrQW40NjRNNmowaS9VenM0cDlRdWZPQkRUdU9icUlNRE5TS1crcm5R?=
 =?utf-8?B?akFGS1hUbGtnaksrdTloc29SQXpVVndnZ1I4TWYxMUdONjU0RlZSTUFsc2Zo?=
 =?utf-8?B?TkdmUVBIMDdrNHdLRHRscThGN0hvZFcrclAyd1ZNcEdodDcvK3piNmJTVnJS?=
 =?utf-8?B?dG90QndTbHVwUWZ6VDNpNjE5QzByRTJQYm1HdURKTXA4NG5SRDUxcW1kTVJz?=
 =?utf-8?B?bnlDdC82b3FSencrOHdjamV5dUNNMzNRK3luR3FJbjQ0T1I2a2g1SE9NUlAw?=
 =?utf-8?B?WVZnWnVCZlJZd3ZJbkpqMEdtWHJqNnZGTlVKUzZnZStBd0dxSFhJaWFjRE5u?=
 =?utf-8?B?cVNPYjZHLzBibXl5S0RDdUk5MFo4TjlGS2w0UkF3UVZ3ZXRqNlEwRm9zZjZa?=
 =?utf-8?B?ZXkybXNFMndZbzIzTjhBTitrWXlYVWR1S3ZRM2QvQndLUG8wcjJDQVBsY0tU?=
 =?utf-8?B?L29rVjlQWkFUWmZKL0NiNk00MUlIZm5ZZlJXeUl1UlUxb0UxVUJZS2JQaHlK?=
 =?utf-8?B?c28wc0pidHcwWHU4aUhtVWVHeGk1MVNwbHB0ZHk2TUZWNDAxa240R2xwc2dw?=
 =?utf-8?B?K2lobzAyYko4SXdSTExOMk8yeXpQcDBhL2hDc0QvTzd1WTJDVG55a3V0aVhH?=
 =?utf-8?B?NGMxT0NBUmJOR2IvSGN2Z21WeTY0YkdWa0xEYThyQ3RabmluTlU4MU0wRWhr?=
 =?utf-8?B?djRYV1VTaitCZVpQcEF6UmtHVnJQb25JM1pESzZkbmttajY0dENWU2lYVXlL?=
 =?utf-8?B?QlZjSFNFbWlaWUF0NEpxckhVTVNPTkwvMktvQW1sektPbUxrQXo5VE1wUzJV?=
 =?utf-8?B?NVFpL25nakkrWERTdnNlZkZNbndtMlpCMzM0RUNPZUdYMEU0Qnl4c2NOWUND?=
 =?utf-8?B?WHlMZS8yMDBKeS9acFlDZDd5ZkpWN1kxbVJLYWhObXRmTmJKUDNUQ20zd2E2?=
 =?utf-8?B?bEEwSU5Pdnl6TkFOd0RQZWxhSE1tbFk3KzJ5QlQ1Z0J4QW1QSGRxR2ZtSVN0?=
 =?utf-8?B?U0J0Zko4R2RlZHdGNHFRU2JpQk1vcEZyQ0lQT21kRlJxbDVKTGI3cU93d0tt?=
 =?utf-8?B?c3R0Z05RU3NmWTBreHhrSEsrNDAxb0txK2hzdVREWVZVMEtQYzNBYk5oVkFa?=
 =?utf-8?B?ejZQLzJncGNGdGZrNmpuT0d6UlNPWGxSSkRwTHVucXFnQmgxQXNmdHB4ZFR2?=
 =?utf-8?B?d0R5NXh4RURkWnY1cVVYb0dJVGJzeHRlMUtSRlJzbzk1R0NSKzJrWlVjMytx?=
 =?utf-8?B?dGNZNUg5RlkvdkpRNHQvV1NnYXkvdDBjY2k4S0hDOXRUK3RRbHJlWm1IYTRB?=
 =?utf-8?B?OWNJL0xuMjJCeWxrM0Y4LzVIZnUrSXlCYTdLYlRlRDFiazNZT3h5MkRmVkdP?=
 =?utf-8?B?SHFFSW9QaGZ1UGh1d0lJSC9BeEltdHE0djdqRlhFQnZzMGdCTk9mWGgyYU9M?=
 =?utf-8?B?RzdoRk1mUk5xSFVxb0ZiSWRuQ2pPblB3dE1KQ1dRUEczb2NSenVMdlBHVUhP?=
 =?utf-8?B?SjVmSUhIMnBSK1QxQmd6cnZsQ2swRFdSaEFhd1Q5Tjliam01VDFYTzYxRUxS?=
 =?utf-8?B?SnlSSkxZYnMvVFprUWdNQ3ZyUWYyc3dUNEpWdjB6V29wSFM5Wktwa3FaNGh6?=
 =?utf-8?B?QjlrVldIeEJRZDlvaklnYnE4RkVQa3puM2dXZkJWcjhFdUhRMG1SSmNheFZx?=
 =?utf-8?B?cjRkNHVNbFpwVndmanp2Uml6UzFhZXJic3ZNQVFHd2tkVVpUa04xN2cvdmRW?=
 =?utf-8?B?WWx6TGNkZ2JDaTVzQ0VGSXNJc256cE5LdDA2K2N6NXdKbFpFd3BhSEVzdzB3?=
 =?utf-8?B?UlNVL0hQRmx0VS96amxYRmlSb0dLZU5aWmxFV2dGaS9WWVMwdzFGcTlMVjdG?=
 =?utf-8?B?REx3bHc2aVBrVEtpaFVmcmsyb2FYTU5xTkZKNU5OZG9XMENIc1pwbHp1T3ZQ?=
 =?utf-8?B?S1RDMFQ4eWo1b0VhMmxqejdSYnJOdTNSL20vTDZDSEdXZmpQdm14cUhUQXlS?=
 =?utf-8?B?TXZOWDRsZXBIOXk5clhzclE1bWZIaE1jRVUyeW1OUlpraC9HL1RibWJtb29r?=
 =?utf-8?B?U1hUYUxpbVA3eEg4RDAyNldMMHFjSVNLcVRXSU5pQ2kwbFZpVUdiSlFIblFG?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e93158da-5db0-4c60-8d77-08da5fe2b8c2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR07MB8658.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 06:34:19.5695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8N8Ao8zDQTRp2UPJntslWhQs2upHYSggMtN0PnH+gJcOjFmlwwrjqYprqSpGk+fNRYRMoFjwV04kMSXCmXqpSqYe3ChpxaEzZxgEUADp1go=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB4250
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Florian,

On 06/07/2022 20:09, Florian Fainelli wrote:
>>
>> "unwind: Index not found eef26358" warnings keep popping up on
>> CONFIG_ARM_MODULE_PLTS-enabled systems if the PC points to a PLT veneer.
>> Teach the unwinder how to deal with them, taking into account they don't
>> change state of the stack or register file except loading PC.
>>
>> Tested-by: Kursad Oney <kursad.oney@broadcom.com>
>> Link: https://lore.kernel.org/linux-arm-kernel/20200402153845.30985-1-kursad.oney@broadcom.com/
>> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> I would be inclined to slap a Fixes tag to this patch so we get it back ported where appropriate, however it is not clear to me which specific
> commit(s) we should be listing here.

usually I don't hesitate to add "Fixes:" tag and this patch definitely could be ported to some
stable versions, but it's hard to say what it fixes. It's actually a combination of rarely
(if at all) used ARM_MODULE_PLTS functionality and other *debug* features, where unwinder is
used. In very similar case of commit 79f32b221b18c15a98507b101ef4beb52444cc6f
("ARM: 9079/1: ftrace: Add MODULE_PLTS support") I wasn't able to figure out which commit
I'm fixing.

I expect those who use ARM_MODULE_PLT and any kind of debugging to be able to backport the
patch downstream ;) 

-- 
Best regards,
Alexander Sverdlin.

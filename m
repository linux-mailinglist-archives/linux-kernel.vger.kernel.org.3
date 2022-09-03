Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3965ABEC2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 13:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiICL3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 07:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiICL3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 07:29:08 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF58B6567F;
        Sat,  3 Sep 2022 04:29:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGL/0OMlkZMrLOcewc3+BvGZPv5lYBxtnch331K9fUv3ZfA7IwvzAkuTVUb6wDRHd2U5CBFWQaLsmMDi/zaaI4jUhUVXK2Ovcnt3cq/xqCAeZfcUflKY0gx/T2jozLFAnxv6ETt10kLRo/dOl/lJ5Xfl9KTGWhjWPdUEvh48RsxOq8n7n6IkG0dbM+zyqqtfMPNS19PoQxtWWr6ggMBO5KOYV5SXYurzv7b7fx17L+wCtztiVHb74Niq2vRC9GOHO2/OJJOqzaLuxOVf3yWIJ1nKqTmzHKZJcSWzWIjlWd0on68rznuxpyGIAy4Jx9JrTXC41Ln7bzoUO8vZWxlbYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbEmb4UBfzFL9fb3MHMTT2aV9I/gkHoNabzMEc8AE/0=;
 b=mNO4fuqgUTYxaQIUFzEh8cgAQYDr+LTS1Xju1aTKOAKPxU8alz35wKfGFeKf59tS1TuSWA/m9l88g8K4IOa+LwM6xSgOlPY5oBnS3rw0tULdcG3EsYUu/pDfJiqtbcnotBDWhEl/kKIH7+XjJ9jUUWWLvOXCPi9fGMBlqUAr3Htg+AyJchkRgZALenJpl0m0J+2fw3+EPj1qJ+a91WAzErFNM0otxJF/jR1J79pzyP/qaF0GxBw7yYErXkdwenHbK6r8unnovkgqenxNc85+lQUkEGUQf9leg+L6mvWj/1/ohLmapBENC30xozyjjF9Ck/MEmL5OgPC9cJ2FYL6jSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 CY4PR0101MB2968.prod.exchangelabs.com (2603:10b6:910:40::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.19; Sat, 3 Sep 2022 11:29:06 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::701d:e406:dcfa:118b]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::701d:e406:dcfa:118b%4]) with mapi id 15.20.5588.015; Sat, 3 Sep 2022
 11:29:06 +0000
Date:   Sat, 3 Sep 2022 11:29:04 +0000 (UTC)
From:   Tom Talpey <tom@talpey.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org, smfrench@gmail.com, hyc.lee@gmail.com,
        Steve French <stfrench@microsoft.com>
Message-ID: <6a2bd4ee-0d0a-463d-87fe-8f56c90eaa43@talpey.com>
In-Reply-To: <YxK02EVt/7OWjfiE@google.com>
References: <20220903015340.7336-1-linkinjeon@kernel.org> <YxK02EVt/7OWjfiE@google.com>
Subject: Re: [PATCH] MAINTAINERS: Add Tom Talpey as ksmbd reviewer
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <6a2bd4ee-0d0a-463d-87fe-8f56c90eaa43@talpey.com>
X-ClientProxiedBy: BL1PR13CA0437.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::22) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e785ddd5-bbd1-4bb8-b359-08da8d9f82ef
X-MS-TrafficTypeDiagnostic: CY4PR0101MB2968:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LHOtOxfY68t+yEAv0oQ2r1yKQimhoNChInEyPRf8y/ZO2572zKLSZwuiZtBwU9YjSRBrBsol0bme8jCao1RQQ1ZjTUvgfcMiIDDys1LCGzzxBUDoSvDLKyDsJ8ymyq80V+xk7rbUUhfAbcGMIGt6tF4ajHOw5GHRDIdB0ndk1drJDAOWRtsRRdUVvMOQ0fLDVYkaiF72GGFbdgKz5JgCPi2S74LQkJxuwg7kmUqAByYKYel4A3cWFNbt5N2tmTt8/OuNctzbWPwRLbc6YZH7fhwD+IA6HIIKWBMeReHkSGc8257OE8p+FfcVG6xBHfELloL0WCbBdUAEJVU1nKVD7tz9k8QJrlqig9nNY8SZbe0ff6FXJq4d9pUhCyEBJSGweTo1o29eSpnNB1yIM4nnfnYwMna3SSxPs510b/JLbKHMy3g9WdBP7pdceCMscsUudCDJgvv+ZhUXx5Z48E0LZw4vMJ98hcJ87rychsqpiZWoW8QBEfh8iuXXaGc9JKJO/UpAfnO7YCClS2GdzjDoUGpSuyKtGrd01D1F2dHYhUwMrUGkFWJIqEcMp6Qp2XNSkGJfENAdvgX0YliS7Oj5F66tKyktVT+kIV7aJ8mv1oHVW7kJiHwf4m8H4KGrNfLoPw8wA7yca4yEGs7+iKHdFg5b1VS5b/4rECJu833CvKO80n5irQvvqrfp33hCrhoJQxOjyTvxB+Du0+yEXJ6coMSC35tkupom1pSJXcD+hcVLYzNJbfbyfhANXhut5pfI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39830400003)(396003)(366004)(376002)(346002)(478600001)(54906003)(41300700001)(6506007)(52116002)(6512007)(36756003)(66476007)(2906002)(4744005)(66556008)(26005)(66946007)(31696002)(86362001)(31686004)(6486002)(316002)(6916009)(45080400002)(38350700002)(38100700002)(186003)(2616005)(8936002)(5660300002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzNwNVJHUWFiSGFVYllFM0RuUlQ3NDhSYmdYdXd6L3dja3NCbFdqV3hzRzIy?=
 =?utf-8?B?aEhseDEvZFZtK0J4VjVjaUwzZEVlSXladUdyMzR3cVdDRHA3RXlIejgycHBp?=
 =?utf-8?B?QWJUQjhxN1JuT0E4THBYUnhkZ3lPbjV5NUdCb0ZhKy82MnFxbUxURHBKQzJi?=
 =?utf-8?B?MW12dmJNNnk3cEcwZDltNFRNSTAxb3Jsc0xtUUkvR2VMRXpsOGcyQkYrUnVE?=
 =?utf-8?B?cWllUTlZa1V5MTg1RUwxZDJOelprSXZxaHJzMDhMeFo4K1kzcmhDUHo3dXM1?=
 =?utf-8?B?ZDhkU1NqdGlkb3VHb0xOUXNDbytNNkdWQjRTUXVnamxNeDZWL25yTlJKWTZL?=
 =?utf-8?B?cUZPVVBzbitabUpjTjh6WTdvQ2FYbEVKOWFCNktoYTRKS3B6elJYcENPZHpt?=
 =?utf-8?B?V2w1N1ZZaXZRMXFETVZ0NFFuSmJrRjZtZWczc1V0L2RxK2M0d0dkZDVBK2tR?=
 =?utf-8?B?N0VRVTYySm9Uakt4Ty9XS3VUa25RcVFUTHBIcGNNQ2VWMzZIcDhJcWkwT2FB?=
 =?utf-8?B?RVJoS0wyaytYc2Y3VURIdERGU2JySHMraFBKYU9NUW9xODg3T25kZ3pmOSt2?=
 =?utf-8?B?dm9hdy9LaEZ0Y2NBaldjQWF1cGpNdndlUXJLaGpCKzZtSk4xUnlSTGN2Z2dp?=
 =?utf-8?B?Tks0SEdCNFY1ZjA1M3FrK1VhbEhuRlFLUld3VVVDYnFkWEk3dEZyM0Q2SUw4?=
 =?utf-8?B?K3VsVHZVRnM3dkl3MnJoMjdubnZXZnNEYUU3SU5BVUFmK2l4UE9SUjhnSzRa?=
 =?utf-8?B?NlJmL3BLZ2JLbnNHSWh0OElxS1l5WHJWOCtkTlMyYTArY2V3OFNHOFQ5ZHNs?=
 =?utf-8?B?Ui9Od01NVVFSaFpYd0doV1M0ZnV2aUFXSnVBYUhEdUR3UTJITmplWWMvWXp2?=
 =?utf-8?B?SldZU012Umo1ZFpQRjNQU0lOZGgzMW9vY1JxMHVNamVReVdER3VrTTBQNXJv?=
 =?utf-8?B?bWZzWkVrSUQ4VGM3Yit5Z1NENGlnNktPNFdjYWJlMnNjdDVycWxMSDhvRDEx?=
 =?utf-8?B?VHd4TzBSdFZmaGZTNTlJUjM3ZHhFc1BlN0lUZHlyNDY5aGlSUUdENlh1TDg4?=
 =?utf-8?B?enJUVlhaWDVzUkgrdkdrQkI2MW9ETFZiSzYzSUJORWREbWJ4ekgzU0t6UVNs?=
 =?utf-8?B?R3lJdkZReTRVQWFvUVpTVGx2YXo3dnE0ZWNaeDFuTmFOSm5xUWRKendUanlE?=
 =?utf-8?B?d0M0bHBwcWR3L3ZuYWlFNlJoQ2ZNRG9CdjdJaWhqL3RIQzhjaUVvNkY3Snkw?=
 =?utf-8?B?NHJTamVoNmp3UkZBdVVoS1BBVXlJTmh4V2RBNzE0UDFhNDlHQ09JS0xERUtV?=
 =?utf-8?B?VGE5UTNFYkdNQlFvb3FKeFRmMXJRTkFUZDZocjFEc2N3L2pBb0UyVnN2aVo0?=
 =?utf-8?B?RmU3VHhSUG43d3N1aUhwVmNqZHlxOWVMTUVTd3oycGIwc2lLSzdmeEdDY252?=
 =?utf-8?B?Sm1VOE1CeWpNMG1tdzlNMUpHWCtJQmhpeUIydzVuYkFNNDd6bWZiczZFSkRE?=
 =?utf-8?B?WHRuY0FkZTA0UTNSRERhSStHV2NlVC9taFFEOXNOY0t3aVdUd3h6VWhjSlpv?=
 =?utf-8?B?c2VERjQ3MEhUNmZhdXdYV1I0c2ZLTmp0UVdXNllDNkRJOFI1eEpHS05aSXFj?=
 =?utf-8?B?Qk5makRaSWkzVGNxWDJ1SnB3MjBjR2xQUy9XRkJWemJsV3BUbFBjelh5bWI2?=
 =?utf-8?B?UFljeGJ4WjBlN2RKVEo4Z2ZVZ0NvUHNGWkFZYlRMOVFLRFI0TjJid1czRmdG?=
 =?utf-8?B?NWd4U2Y2ZHRtNUxoalAvcG5Zc1BIOWNnL1h2V05jLzJ5ckZsbVpRL3Noay84?=
 =?utf-8?B?TGkya0JjSWllWGQ1T2Mrd3NzbUVPVjlnMFpSRFBjN3RJUDVPd01DbWlXeDU4?=
 =?utf-8?B?eDhIalZYc2R6VlUxemR5dElMOWRkdjZDNDBZTlVWUWJRRXRYYkZ6aW1LR2c2?=
 =?utf-8?B?cEZMTHNGTlAzWlpQakhjMUFjMHM5dXJydzYwaEM1RmNKUzZmOExxUVNSdHBX?=
 =?utf-8?B?T3FscEFwdUlkK1M1U0NJVXZMSnhSWFdQTjRhVU8rQ2tzU3pXM2R3bHFRTW1V?=
 =?utf-8?B?bkFPQmY0QmtNMFN0OXp4T0dLdXMvVWxDMWU3VDNHSjgvSlhHbCtJM0NKKzN5?=
 =?utf-8?Q?OOtQ9mzCRuM10sbFAL16ifNj1?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e785ddd5-bbd1-4bb8-b359-08da8d9f82ef
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2022 11:29:06.3659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4SMJ7CYvW2vGOwCFKxqYf5Jl7KBTmOMPFEN0ugqLkidBxL7zYqzWsSQSSAL/K/A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0101MB2968
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sep 2, 2022 10:00:45 PM Sergey Senozhatsky <senozhatsky@chromium.org>:

> On (22/09/03 10:53), Namjae Jeon wrote:
>> Tom have been actively reviewing ksmbd patches as well as
>> smb-direct patches. He agreed to help us as a reviewer,
>> So adding him to reviewer list in ksmbd entry.
>>
>> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
>> Signed-off-by: Steve French <stfrench@microsoft.com>
>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Acked-by: Tom Talpey <tom@talpey.com>

Thanks!

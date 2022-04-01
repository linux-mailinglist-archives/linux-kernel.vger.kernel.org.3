Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618254EE5E2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 04:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243931AbiDACGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 22:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbiDACGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 22:06:13 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2122.outbound.protection.outlook.com [40.107.255.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03028BB92B;
        Thu, 31 Mar 2022 19:04:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k14qdPARtkcSUj2pppS3w3YYQtn4cqijmDM+T1W2fYvit5AhpeL6iisu19ls9Av39E8bYfX/HZ9JY7oRJKzbhYhF7g6qDmSq6gB1nAlFF2nSKWutjR4MJTtoP9pEPTt8paK1Yx8TjAO/DdoLWlHsY01rx0GXC1bsR4X3y+Z6sM4hEO1N8wuTcl3DKmRdg5mDdeeKS4/N31WNeA6voumH5L8xMxpcPsr+XzPC8ILlO0OyVrb9kW3Bgse/7Ncl9snuqEqVUUzYl1rx8++I01Q01xYHaxTWqW7wpa/WyzZuAju80iQUghLiNvVcWLsbdLc0Tg/bv2o2jigJALIclosAeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiBnT/8JkWk03Chv2pptfhl+80j2+qFwuDtET6DmtSg=;
 b=oC/tVvRyLDKuXxT8clAVit6sHA51jkwxWggvRbIhZPNf4G+W4uzJ9EPX+G+DRvD8EmF0c5Lw+DIX5WSxWHDOI8+1E1kZzGSwVj5ivhx29sAJG08kA8cw4U3WPSV+3hMHR3gMeBaiVmChr9ii4D4MlArC8FYMRdS/vTXKyOC9HqbTRw6InPjZKDOwlRUP+vcU3wxwcyIIJd5cr/pDBHfLIS1u0WZFu62S2uoyFbHDuOvEtuUIMzqRWC/BfuGRRYwgUzNVIybF20K0LTGaUOwozvYkAYwAHev7HYlC9QNbTWIx5sVReQePUR5qnniZzrq8/4h92RD2fuoLjzQP95MmUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiBnT/8JkWk03Chv2pptfhl+80j2+qFwuDtET6DmtSg=;
 b=KApwhYvpJi8waJSXyxbBB/Fk2fgMvA3yzCi3L/ch/u8MyR1/vFPP6Se+LrOGvyDbfE/MuDRSWpdH96hUEVlVf+G5uEZCnLTpJpuPjW2qsTHTU/ffIKVNKzDAcZLoO1fh18ZBvOeOn1+08HBwzdM3KmRT3dka61fpZj1WkxKAADU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 KL1PR0601MB3889.apcprd06.prod.outlook.com (2603:1096:820:27::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Fri, 1 Apr
 2022 02:04:19 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732%4]) with mapi id 15.20.5102.022; Fri, 1 Apr 2022
 02:04:19 +0000
Message-ID: <35ceefc3-3f8c-f3aa-e468-1f21161f920b@vivo.com>
Date:   Fri, 1 Apr 2022 10:04:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] rtla/osnoise: fix NULL but dereferenced coccicheck errors
Content-Language: en-US
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     kael_w@qq.com, Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220322113253.57390-1-wanjiabing@vivo.com>
 <2afd6cba-1a01-0c32-eae8-c4f9f7e76732@kernel.org>
From:   Jiabing Wan <wanjiabing@vivo.com>
Organization: vivo
In-Reply-To: <2afd6cba-1a01-0c32-eae8-c4f9f7e76732@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK0PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::16) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d15f7a67-5fc4-47af-4aa7-08da1383ee66
X-MS-TrafficTypeDiagnostic: KL1PR0601MB3889:EE_
X-Microsoft-Antispam-PRVS: <KL1PR0601MB3889E96AF2C4ADA63CB7E38BABE09@KL1PR0601MB3889.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mC0P4cmS4jwP9uUobOjLOqeq50aSGFps4qRT/TsrgzyzjfBEq4WFMlpwaVy8VB9wO2Oca7TFrYqvRRtYNcauhdC+uN8FUrsu+w2Ka9xEZzYJfwLUOXy7/6Ixp4Ot9E40zYY1K5WPyxnYgZChFElDbyEnQHZUImE/XeqThXGvOSgN+hNAYazbyWteIJmcvSRQHB3dMO1eDKAyiO9cfbO/ss6W6QEADrjcqvEifDLsG+/oE0s11+jA4+I57z0jmVp/F/2At2vdq/aDuf5mpSdP0aJFW1KUSmAQsa8QIHMK/Ek1QLGZ1rwDAQk4GMvvYdnSs5AWKzQLV48zM8zo4MIQSzfbWeM2CFYtKn3Ek/4SlgDzDBVir/fRG1Ea4mC+CeNoTUf1PxSZ8ViBZnSHPi1nLptZ60QglL3lwhWN2tln4sjd28sTKskYwbpAaCHNCRE3ELOpOqgz00HEQsIOC0Y6bkYX9XHmxLttGs9nRXHh6sKBMv651rnZSHx2oUdGcKSQbeNB95i/zPxqK7f1CS2jjCdZsX24Tp0X3NRApDrcXxl8TU4I7F+3jZmll1PIJVzyMSb2V7dT6sv9gQuDtnIhJ13wliWmEET0bWZBt8F4B0XmBUZxquKR582O5YFqKMsN5Rz+h9xG2cidskgnAOWSGaeCOxhqG/aLsrvZz1yFsNxkZt0KFGdauplmuxidCuV8qcXcxjxdFqGmuKWFohy3SEmEGJClDzOQszr/+ZApIJ0fidRslJdKZsuXk8HMOKa3kiJCpfKhQzoyJdIvm3OR87y9bVynpmHMTOgtjXwxF5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(86362001)(83380400001)(316002)(4326008)(36756003)(8676002)(6486002)(66556008)(31686004)(66476007)(66946007)(6916009)(26005)(186003)(5660300002)(49246003)(36916002)(8936002)(6666004)(508600001)(2616005)(38350700002)(38100700002)(6506007)(2906002)(6512007)(52116002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2lNUkd1aEQycG5RRGpMTnRxbURLWWthdFBKSGtTV0lHNnF2c3BadUJYVEpY?=
 =?utf-8?B?L2lLN3c5ZlRFYlRPUTg0QmFaU0FFRmpFRVlRclBUaEd0WlB6QUZKSmJBRVR0?=
 =?utf-8?B?dHdmdElJdk1oaHc3M3ZJdnlEaE04UTNuek9oNHl3STJhdFBMei9LVXJrQ1hx?=
 =?utf-8?B?K2NJSlBFcjJUdVJJZHhnLzZyQ2xDWEg3cjdDMlZGQ3V6NjhKUFBRWXo5SzhL?=
 =?utf-8?B?cW81bVAvcjh5UEFsR2xFVXRFNkZ6dFB1S0ZyYzdraXpRdXk5TStsTStCbnNS?=
 =?utf-8?B?TzNCQ01nOWtDbDk4VnlpWVhwVXkrTUtZWWJnN0FFZ2ExOERMZStNQTROb3NH?=
 =?utf-8?B?TWk4UGIyYVhoN0kwZmliWERRTFFPbGNpMmIwMFBzWUZaa3pjWEYyd2Y1YlMv?=
 =?utf-8?B?WmlYT0RtYnd6cUVXK0FBV0hkUklwckdDS2pIbmZtbU5tbkdqRnk0c3BKNXFm?=
 =?utf-8?B?RzcvV3hJdFVBdStiTUZrZzl4UzRhZ1VJVzAzQ2ZmRGhFT2wrWjR3U1FRMk5D?=
 =?utf-8?B?Vks3YTk5OHVGeUE0VnJRTVB6OGhWL2VkR29HV0ZEUlZTZGlFMGNxRzA5TGlF?=
 =?utf-8?B?Q3U1MFdvTWd1RHU1Vm82bzhBZVlPTUJaU3krK0YxaWs5YVRMSy83dXF3MDNO?=
 =?utf-8?B?WWdSTHpNTjNBMjcwVVJPc2RXdm0vS28zQ0diSkR1NlQyNEgzRDJDOTQ4YzJu?=
 =?utf-8?B?blMrT3libGVUTUc3RmptbUgxWXFXKzB1YUl5K1pXM0Y5Wk55WHBPVGFhZEw1?=
 =?utf-8?B?VXBoS1JjN3MyQUtRNmtsY1F2bklIMGdUVEt1dVBtc0puRXd5Yjk0RmF4SUVr?=
 =?utf-8?B?ZFlkZXp2cU1SNXRwM1hwNW4xVzZjNUJZckNnSjI5SitxOHRWcFR2ejJwTS81?=
 =?utf-8?B?VjBJaXZtY0VxVTlDTEhYVDlsejVuWWprc1dPWHZMRFVTSlp6NklweE12ZzMr?=
 =?utf-8?B?cmUwUG1lT0k4c1JSTXBMaHpVMUdTTHhmeWsvM2dyWDBBcmxpSUtBWTY0VjJG?=
 =?utf-8?B?WGVJMy9EbGFObFFBM0svdzRGMm92Tk11ektSVExSTTZ5SVZMa1VSMmJiTkNv?=
 =?utf-8?B?QWdaWWdmY2NBejBQYjhoYnl2eVFWZUp6NFptRk55M2pTN0NlSDBOVWJZZU8w?=
 =?utf-8?B?OENkbXNzcm1jMkZSZkx4YVY4ZFNDMlptZ1hnTUtLVzFZVEw4VGdLWmIxRkhp?=
 =?utf-8?B?WGZmZzFYQkxPZjN3akVoRklSWlE3aHlPaVR5RWk4bDF1OFR4OW9SYmhRckJy?=
 =?utf-8?B?aUYxaWplc3o2WWxkekhtK2daUTB5QTA3Um1ad1N3ME5ObzZKbFR1SWxCSnZX?=
 =?utf-8?B?TU9zK1NSalhzelZEMEU3bnQweXppQkFoS2htVlp3R2t4VHZ0WVA3UHU0K1JR?=
 =?utf-8?B?WFVaUXM2WGZGWHhQbnVZcElDL2hNOXlsek84ekFSdXVxR1V1b0MrbUJGUXhJ?=
 =?utf-8?B?NUtrNjJUSVRGQVJYN3RZaXFNRkl1STFCV1d0YXJudFdnMnA3L1V5VWJjcXdW?=
 =?utf-8?B?bWNjZUtGU25JcEFrMWFmTXNsR0FHOUQwUytqQUQvUmhjMVRQU0hDMklFeldv?=
 =?utf-8?B?Sk9QbzNnMnJUSW9QR1FWMnJSaHg0TEpjZEdtT0FZSXY3WVZHT1VpZi9NQ1lF?=
 =?utf-8?B?S1pxY0YwL2JSRTViSVFtQiszQU1nUk1iMWRodk4yWTlsNURoQmxCY1hQcGJR?=
 =?utf-8?B?TWllRkRnWHE5MUkvTUlWTVJad0JnVCs4THoxaElJMWYxSExKSkNjMFlSSWQy?=
 =?utf-8?B?L3ltOFpNSHBVZU8rQnNqWmZWV2NaWWJGY0hPZDFOWWxzV2Vrcy8yaGNBSjEz?=
 =?utf-8?B?VGpCWStIVklBLzdZTWQydk5nMHlOeWlNOUp0Q0pHbm04aWpRVFBGWEl0aFNI?=
 =?utf-8?B?eThhbmN6OTBhQ1NFOEFWMnhPZ2t4QUx5MWNlY3dkaSs5dUxOOEVlN3U5dVlM?=
 =?utf-8?B?VjV2ejR2dGZKd042YUdEY2UyM3haTDF0UzVzMVNlTkFZTTkvUGRWRU4rcFZI?=
 =?utf-8?B?aW55aDhJaTYzMlZlNmtzQUR3VmM0SW9tQ0llWWJRZmlvdHozR3B3YTFlMmNS?=
 =?utf-8?B?U3hqM252ajhTdnRUY2tyV2RuOG9LZFZFeXlaY1EzYzFiOWhjU1p2anFVQUpK?=
 =?utf-8?B?bDh3TWtwaHRuU3VyYW8yVk0zRnRMVFhPWHRpWlpnWW10RGdVRFZuWkR5bks5?=
 =?utf-8?B?N1ozSmlVaGQzVlBaMm51SGhxTUdLRkhwTFRsVE96eUh0UzR2T2xPbC8wMG12?=
 =?utf-8?B?Mm50ZzJwVUF3QTVXUko3RXZYYXYwMUNtc2g2S1dYcDQ1dGY4bDFLRllaamlT?=
 =?utf-8?B?VXZ3bk1hVlU5R2FaUU1KdUJlRStqMUtJV0pINWs3YjVyaFNNdmJRZz09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d15f7a67-5fc4-47af-4aa7-08da1383ee66
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 02:04:19.0171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ezpCEYflBcJkacABOiTqbJj7xo6c2EoaooXF0sr/jw4Asi01PbnQC+hyjsgWPNb/QoSwWDZFhH1KlhYOZPC9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB3889
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Daniel,

On 2022/3/31 20:25, Daniel Bristot de Oliveira wrote:
> Hi Wan
>
> On 3/22/22 12:32, Wan Jiabing wrote:
>> Fix the following coccicheck errors:
>> ./tools/tracing/rtla/src/osnoise_hist.c:870:31-36: ERROR: record is NULL but dereferenced.
>> ./tools/tracing/rtla/src/osnoise_top.c:650:31-36: ERROR: record is NULL but dereferenced.
>>
>> "record" is NULL before calling osnoise_init_trace_tool.
>> Add a tag "out_free" to avoid dereferring a NULL pointer.
> Yes, I see the problem.
>
> Please, change the Subject to something with better information about the
> problem, instead of the way you fund it.
OK, I'll fix it.

>> Fixes: 51d64c3a1819 ("rtla: Add -e/--event support")
>> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
>> ---
>>   tools/tracing/rtla/src/osnoise_hist.c | 5 +++--
>>   tools/tracing/rtla/src/osnoise_top.c  | 9 +++++----
>>   2 files changed, 8 insertions(+), 6 deletions(-)
> Please, also add the version of coccicheck you are using, because it seems that
> there is a problem with it. There is a similar problem with timerlat, added by
> the same patch, but it seems that coccicheck did not find it.
>
> Would you mind to check coccicheck, and also add the fix for timerlat?

Yes,  I used null/deref_null.cocci to report these warnings. But there 
were no warnings in
timerlat. So I check the null/deref_null.cocci and modify some rules.

Using modified null/deref_null.cocci, there are warnings as follow:

tools/tracing/rtla/src/timerlat_hist.c:905:31-36: ERROR: record is NULL 
but dereferenced.
tools/tracing/rtla/src/osnoise_top.c:650:31-36: ERROR: record is NULL 
but dereferenced.
tools/tracing/rtla/src/osnoise_hist.c:870:31-36: ERROR: record is NULL 
but dereferenced.
tools/tracing/rtla/src/timerlat_top.c:700:31-36: ERROR: record is NULL 
but dereferenced.

I'll resend the patch and fix them all.

Thanks,
Wan Jiabing
> Thanks.
> -- Daniel
>


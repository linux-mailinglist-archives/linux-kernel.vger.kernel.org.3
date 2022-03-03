Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3A54CB9AD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiCCI6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiCCI6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:58:39 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80092.outbound.protection.outlook.com [40.107.8.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6A515E6E6;
        Thu,  3 Mar 2022 00:57:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpvNNKbb25PMp296wPIRDX6RQatO7cBEyoNwjMPuuT6pt21IO0OqW2tDYYLXPgQ5rk/s8bQfwqDDryyBysDN6uOExRF8hvtONcU36Nb/ROfj+aeyr0Z/Y58MYuhyrb8PyOshdv8gKVqWvRKiCuhmeySXbySXerLYQf9bCeixRDOdC0N3iRH2EM2h2ukzK6102Z7cQR3q4E4Vqr4PzzcXIvVBBwUVjIMJbbQ1rRDmK65ruZhN4phQBdF3PQCzLN1EAcvTofGWLk2odsoJ8GfoyJ+anOvcpeJD5+NuLebUoB9vTQQodR/3MvfdFPdImnYTAcHVLajvZRJEyd+zEbszcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMha8cZHrS2QIjK4jXJqIaHlJRyYTTcP9jzSVSQomYg=;
 b=mO2WwIg1EQ4Pg8i0hax9IQ+hD7ePWDps/ZrprdBqckvxuDJDxFpoH+xkg6Q8eCkBzYJ3CdceGbRK/drtbf5DWI9M4/MN/r9FHft5d+O/ZI/rEk59fe6bzLhlQxtTQObVx/SAwdpXs+n+CCi1IbYkxI5FterM3fIUtP3sNJIaWrRAz/wJQ2UAHthpRx1ej6Wb4KwHB/Gonyn1cSLjj0PlxUGKYDptiPsEsoSqHym+wZ5AVFsgMUKO85JCvEyZjq4VquE/lFYQSjq5EY+oU2AucdVQBkyz7yY5dPZJ8+vYyVh4ZDpKhPLG2ltPRjQYXwphKVgTG9x1yNXzJATd/bHwBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMha8cZHrS2QIjK4jXJqIaHlJRyYTTcP9jzSVSQomYg=;
 b=Nu0ne2ohUmIGGVL8u4+25OJU+wgJSedkTY3CKgCJ7Pmoa17tt/M4lhzmg9COOlVdIlTpzg6scK5rx4miHOZRaIET7p4zRm9SlPvahcpxqNTBe3oRfMJ7aXam9s5lF3raWc0enUBT/kO4OSASB3Z308xTpW9kVy1r/EJz+kj5eZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM7PR07MB6916.eurprd07.prod.outlook.com (2603:10a6:20b:1b4::19)
 by VI1PR0701MB6959.eurprd07.prod.outlook.com (2603:10a6:800:194::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9; Thu, 3 Mar
 2022 08:57:52 +0000
Received: from AM7PR07MB6916.eurprd07.prod.outlook.com
 ([fe80::e14c:59c6:7109:de9]) by AM7PR07MB6916.eurprd07.prod.outlook.com
 ([fe80::e14c:59c6:7109:de9%5]) with mapi id 15.20.5061.006; Thu, 3 Mar 2022
 08:57:51 +0000
Message-ID: <9e868438-c0ad-464f-358c-5ee77bfb7f4f@nokia.com>
Date:   Thu, 3 Mar 2022 09:57:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v7 2/2] hwmon: Add driver for Texas Instruments TMP464 and
 TMP468
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>
References: <20220222223610.23098-1-linux@roeck-us.net>
 <20220222223610.23098-2-linux@roeck-us.net>
 <20220302175941.GA2523098@roeck-us.net>
From:   Agathe Porte <agathe.porte@nokia.com>
In-Reply-To: <20220302175941.GA2523098@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR08CA0017.namprd08.prod.outlook.com
 (2603:10b6:610:33::22) To AM7PR07MB6916.eurprd07.prod.outlook.com
 (2603:10a6:20b:1b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12afd998-dcf9-4fff-861a-08d9fcf3e607
X-MS-TrafficTypeDiagnostic: VI1PR0701MB6959:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0701MB69590D47510B0441D696CA0D9B049@VI1PR0701MB6959.eurprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aNBak5WQSIdl9AkyRolflb3TPIimETLYcrHxaFsUQvryOzV227+FuVXtSd2ZsVN9aclJ5tOtCse6lqx+sJBHrDSR/Lvakwlry6390EYx0muzaKjrwzBZuaB2T5Clmv0f+4ORkNqQjd2xu5HhnEYZHIBzwV08Es5xWrxcjCCp8LOIT6umsXPk9Z8z0ocmLsdxvhezHmBKAkAOHFApTWb21HAjH+d1d4LUm3GeIo8RYbjim4T9n9i1Q2TMfzDVDTMmB15jGlXeWZd3cR/1rRTQXkK6L45leN7vbk9gxRfGNEZf6bNWYcLJIziIu+lFwWA3nZzOK9t7qMIP32YiKP7ItvbD9lRisBwQ0EldpPq9Z5utyZ1ibwcM7IaO5mjrs1koHc0Myrj1QR5u+DbhFhxUjXcTpGF3q5SU7uwh3g0b5m0LABiBVcFeIvvsPONFv4nbBE/XdpX4NM+mupYRVB3r86qK30P5oFlQS+knvuPz65gccq8WWgK6SPYZoQJShr1fDSml0Oh77nJbL+6G7q9Vgz3F+Om8D2QA2nmo2vNnW1hE5/XswW92kDcsvAFMMU2O6y/bWXDp30wOD9nm4ehinQ+eI/yhklghaXfZz3W0h35w8OioPZ9968re1QRP3++yK8DMYDwmMu0UvpbeuyPeAAqBSQhlmC0VD68D2e71nGY1a4ZKRn6jCH/PHahIGnnZwUlT+rovlmMUNg+3asqYHJvLxUZFkh9DEG9mVDTxoPOUvUeVH2UrFbwBkgxLyYSP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR07MB6916.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(31696002)(6666004)(6506007)(26005)(86362001)(107886003)(54906003)(316002)(6486002)(508600001)(82960400001)(36756003)(6512007)(66574015)(83380400001)(38100700002)(4326008)(31686004)(8936002)(2906002)(8676002)(44832011)(66476007)(4744005)(66946007)(66556008)(5660300002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0l4RDJOcldvNVpEYy9WZUZmQndQRzRwbGY4VzNtSTI1NFAxeHpZOHBia2ww?=
 =?utf-8?B?eGZIQ21mbG9HZEdEM0NOb09FcERXV1lDbnlabmpZNmpnL09XTW1PcnZUYldL?=
 =?utf-8?B?Z3IzSGFGTXNpN21OOVRTSHhFTXVnR0pFYnc2U0VBVWtaeHh3MndhK3lpa1dL?=
 =?utf-8?B?S3B3RUdvdjM1bkw0cFRCVkVuSGs2dGErZ21BVUJBUDZ6eUJ2alN3VFJ4MWJp?=
 =?utf-8?B?cm5YUFVoRXhjMWxMQXZ5MytNK2hmUHcrcHNWZUc3dmREaVRGVlhZc05JRHc5?=
 =?utf-8?B?bUJnSlp0NGZxc0RzUFFiSjlrTm5mYVVmRFpybGhobVc2a0hMd1VINFZsVVlk?=
 =?utf-8?B?c3lzWVVIWktORnJVMWdiUnlHc24yVVpVOVBTZElJZE5MTG5qd1J5VWVkbXNU?=
 =?utf-8?B?U21xOXRidWZaTHZKMi83YStxNjVKOXRodGhqNmxPSGdvY0N4Z2ZheTd3NE40?=
 =?utf-8?B?U2ZxM2xBNVZsdzMrN1RiSEVTcEowSGUydFdSQzY1TWh3TS84SzRwcWlIeDBM?=
 =?utf-8?B?NDdVUFl0a29Nc3VRVkJXc3Y3eGg3c0lwSWlDQzBZbFJIRkFpckF5S2laUEFB?=
 =?utf-8?B?b2crdDFXd3hYSnBEdUhXd2pEY3JUdGw5WmlFcmJlN0Vpb0htYWdvekZ0YW01?=
 =?utf-8?B?Y3UvTW4vdkt2NTQ5dEpsRVNiK3J4MnJNNVR1Y2R0UUs3UEhiU0RManNHNlBh?=
 =?utf-8?B?M0lGZ2J6c0g0ZW5vZ1RNYkJpbFdzS2xkc0JFQW5yNUloOGh4SzVqakdRSmxS?=
 =?utf-8?B?WmlaNzFaWUF2VTJJL04wOU81N05ZR2NIclBmRzdKbUM2YkFqQmJkZlhLOGQ3?=
 =?utf-8?B?dVZuLzBrOVZ0U0RNTXBMYVBrckR1cDlhanQ4bmNiUGxMQWd2andFQkU2NGZi?=
 =?utf-8?B?VGZCaWtwUTgwM25DWVpsK1AzUGF6WUpZeVNFZVl2UGpSUC9ELzNKR2RacVd3?=
 =?utf-8?B?dWd0VFd4c2FTbm42d01HZWpHSWFHVkN4T3ZHYjNNOHBRR0h4S1YxWEhhSllz?=
 =?utf-8?B?KzAzN3IxejJzZG1Cang2QVZ0cFF3bjNEOGpDZndnSVRRL0dveXVzNkZIOTJZ?=
 =?utf-8?B?Sk9ZWXFzNlZ5RXRqZUpqSEpFZnRhOFR1Q2JPd0s1RUlEK1lWbk41TExpT2Fn?=
 =?utf-8?B?TWhvTFVWTmphWHM1N0FVY3QwdHJHNXRGYzdNcmdBQytGbTg4OWQxWnJCSE9x?=
 =?utf-8?B?MzNxMko3d1lhWmtKU3hYbEtvZFpsWDJkTDE5YXRiQW5lRU9ITW4xM3hjZlZR?=
 =?utf-8?B?emIwdHBRRk5wRUxLWFYycHNHbjBOWDdCUjNuWExwRWdaMTJXU2g1eUtNdnpq?=
 =?utf-8?B?b0VpQUd6clVqbjJCbk5YVktYZzRMa1BMTCt5c09XaEZjME9PeWVSejM1Qm9C?=
 =?utf-8?B?aVRPUEE3d1BnK0xuSnFjQ3FVa085R3lmYjBRcWNQUWgycW9hNjNsdXBNUlBx?=
 =?utf-8?B?QTBEQ0M4YzFhRXk4dkRXdWgxMDJiY1NnMXFYKzJBZCswcWJGTmw2Wk16N0RZ?=
 =?utf-8?B?MXBLTkl0a0ZKRG1PS3pjbGFpY3M1a1R3cXlpMFBLemhmeHJNSExVYzB0QWxT?=
 =?utf-8?B?emwyeWtkb3NhK2h2SlJ6SU8xbWV3MXN6WWpKNXUrd1ZVbXVmcUwyRGZDZWtU?=
 =?utf-8?B?Uzl3SkJiYXp1QlB4OHduMTE0MTRZTm1odzl4b2lrWFBCWThQL202bkplaDRy?=
 =?utf-8?B?NmhNWTV6UG1Vb2NPdGNINHNabUExSDNpaWRhamRKWVJ1TzZKek1ZcUlCSmtX?=
 =?utf-8?B?VFZFcU8wYjVKZ2ZUK3AvZlgvNW8yeU5ReVNaY2NUT1RITUE0VS8rTmpVNGps?=
 =?utf-8?B?cm8vRTFEQitlSEE5MHg5UXZQSVVQZmgrTU1aSFdlN3N1dGxTTjh0emNBZTBU?=
 =?utf-8?B?SVhkQ2ViWEFrdytsYXdwUm9jeUptMWVMQmM5dnpTdVg0UFFwcXNkM1NrK2g2?=
 =?utf-8?B?RWZXeUNoQUtOQkY0ckNobUNQWVU5d0pVTkJGZzRMVmE5dWxwTDE2S0d6S1Y4?=
 =?utf-8?B?RzkrTUpkTHgxK3dMNXJ2ZzFUNjFsQkEzNjU5SXlNZDZjY2lwSWJVTHZhc3Fl?=
 =?utf-8?B?akE3a3FPUTlqbjA2REt0QlpaUFJpV1pzcE0rOHZrSFdjbVZ2b1haUytlOUlF?=
 =?utf-8?B?VTlTVG1ZczJrZzcwZDlESG8wckIwMUNPQVB3VytqMDBYSkpQZlI4WFpWQjBy?=
 =?utf-8?Q?j2jbLJSmbcwwbinYZk0T878=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12afd998-dcf9-4fff-861a-08d9fcf3e607
X-MS-Exchange-CrossTenant-AuthSource: AM7PR07MB6916.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 08:57:51.8796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zp4tGLoYvs4pupsKPcUE/BYIAADeHF4hoQaR4OWxNlE7+hwJYlI4NX00pTy3xOfNSnHKLDdrdQ4pp/9NScHjAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6959
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Le 02/03/2022 à 18:59, Guenter Roeck a écrit :
> Any review / test feedback on this patch ? I would like to apply it
> before the commit window opens, but the time is getting short.

I thought that you did receive the TMP464 samples and had the opportunity to test on it. I will test v7 on our hardware equipped with TMP464, verify that DT support works fine, and will reply to this email with my findings.

Bests.

Agathe.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CCE4F820E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344302AbiDGOr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344225AbiDGOr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:47:57 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E49B6C1DA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:45:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzfS3CoJqsAB6lWYp8IELL56P65PDCy28X8C+JoE6c4GRzZZU2DBmisRClrCLa4ZOpZmVbZ/E9KdvFdeundkVbw7K8K2OQWz6NN7g2BlttdsRWt8gbukpHeKSL59iBc6+s3+9BCk7/FuYwxK+D6qtXPO/5OQxe9QmGEz6PId8N8h1LbDHniM3OWQtu2dwcnrGI/YSkr6lqYn2GjPLq797YLRvnqpvcqhuuC5RsRHd/8W2D9tff41AnTVE7u8w2t6mx7s2K31+jVqlqmYQpfCtcmNrY7HxgOeslLAadgAZ8Q9FSUWlxeaRjNE1BAkxnsW8z8tia236vezlHkBhbj9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQCBMgiaTKrtamaHOeXd4wm9g/qZ8PUy2vpdz7sVcQY=;
 b=mnIBgLRE7en5ZimgK/NiOti5TSCtd3BbD9JEvT681OAUWXxYkIbQc/pLkMUPEYI1kc8lErAB9GUcpE7oGqZGHkm9J0cQ1zRAgWv9cVTxsgaNIQ6buN0uNhXxlarcXW5NLW0qY6gZ/n+nPIHU4GIembwqlt75FgGddREu+LtATk2JT5ccXSJxQuJt8qVMA0soy0ecBk2UpAI3v1FXUvUkEKW82kihrH00n07IjFGM1lorIsjVNlpBv0KQos20J7jpJEARbME8f2PWmLTgWqrQsB+NOCq6B4DRjqm3QizTphwQeXw5VA3Op2chMtyNfPLP7ZR6lOpjAv12o38OKAFuTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQCBMgiaTKrtamaHOeXd4wm9g/qZ8PUy2vpdz7sVcQY=;
 b=qX/RXtPrwmmRXANFH+GdGgd0Exc1WvwQIxJ1G4Itt5u22M+5R95bJ4NN9BZWFNf6zToLJwa2j0aVUfrmArNuhZI0lIxzInRqk0EQh2+LgLAOrPk09yf+0H0kxFrnYteh46aS9iNtLe5KLDQ4CgetQlqoHgcZzUnYOKjM+gxTVus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by CH2PR12MB4857.namprd12.prod.outlook.com (2603:10b6:610:64::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 14:44:05 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::eccb:463d:2d80:63b7]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::eccb:463d:2d80:63b7%4]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 14:44:05 +0000
Message-ID: <95a7091a-bef8-e42d-d875-77b56b856d51@amd.com>
Date:   Thu, 7 Apr 2022 10:44:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] drm/amd/display: don't ignore alpha property on
 pre-multiplied mode
Content-Language: en-US
To:     Simon Ser <contact@emersion.fr>, Melissa Wen <mwen@igalia.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Agustin Gutierrez <agustin.gutierrez@amd.com>,
        Zhan Liu <Zhan.Liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        markyacoub@google.com, sunpeng.li@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220329201835.2393141-1-mwen@igalia.com>
 <oPxlwpfhK4TKsOfqVS-hfX4WN9CvusPH8C6rRq_NKYMh_YocjF9eBY13cALFQiqfCH_OgjIcXFkrjPU_bndAItgl31kjkkjmZlIN5vy7lxU=@emersion.fr>
From:   Rodrigo Siqueira Jordao <rjordrigo@amd.com>
In-Reply-To: <oPxlwpfhK4TKsOfqVS-hfX4WN9CvusPH8C6rRq_NKYMh_YocjF9eBY13cALFQiqfCH_OgjIcXFkrjPU_bndAItgl31kjkkjmZlIN5vy7lxU=@emersion.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0030.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::21) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7300837b-9554-415b-fe70-08da18a51064
X-MS-TrafficTypeDiagnostic: CH2PR12MB4857:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB485784089786376EF6F6689898E69@CH2PR12MB4857.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tga1uVQYrc0JQc/wl72ihECTecOUVshTmGj9Q2sDPwVTWyDRUzGcpYrRwQ6TbFie+HYKPQ2nJPMlz4cjWLne/moMiBSYcU6p+zBysdm/00DaAUg7prLpQaRset06aZ26dRXQEPNMCwBIslbRnP8eM8kwwaMWAyaH3tCO4wMepE3uNd+5fnpXRwqGOYZ1LPOYgzf88UM/QjkNVdUZrM0Q2XMkzL6nevLpVn/esjOBijuSz7hW+gZFZLFQzrcOk6/JdPOjfQ/KtnGm7Q2gERS9HEwoNOWL+6rAQXnau9QQubVkF5ZxqAtgduoqsiWLggOfTCGM/nq7dTMxYf3NxrQG3sybINal/HFgwFWA3wsddbaM3+4XmGW08EV4ncNcbJmW9LpB2r1ikBNrbKIiFVepVUT8Yu7/CnHISEHHUahR2zc6C3qXR0kobNsbL90nEs35MS+ETavgmX6B8CT5s6t1RTNn9uLDm8z4rlM0hL580nVdGyluVxBOEe2LkfyULkOscdch9mIkBdzK9Hf5LHYtf1/zeKEtuz95/UpEUoCV9CvEPK+/7MgbLJf8wZKTnAhjlvsqp6lX35bTv5VBNVjI+84NtpU3/cv/MIaApN43jOeBktxOLaaaCt0BeV5qTmqOqoaHC7G5y75aTHzec/uZY+AdNfh5jn1aXEACkunhp7L1Jh1Gv2SyZk/UowEyfq2LZ+l0ekWjm77WCoXqyNqIEsUq4FZwO7AwziUv13U0t3c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB2941.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(8936002)(36756003)(508600001)(2616005)(54906003)(38100700002)(31686004)(316002)(6486002)(966005)(186003)(66556008)(26005)(6512007)(31696002)(66946007)(4326008)(8676002)(66476007)(5660300002)(2906002)(53546011)(558084003)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzduY21MREN6dFVCSGp3RElwTWorcVhuVHViVlN5Umo4aXkyaUpvVENtU1Vi?=
 =?utf-8?B?a09KSVRDQWhaWlZxWS9MMHBQZzVVUW95L2FiRWE5eFprbkFVSHJDQm5NbjRt?=
 =?utf-8?B?RWV5TmZlaFRxNVorK25QYmdmMnh5SVVXeXVrclZ2Nk5ScDR2ZCsyUmt6RDl1?=
 =?utf-8?B?cU9LMVAxNEtyVWd6SmFuK3FIM01iem9wWERYdDlJS015aVdzWTNZT0NjV1pZ?=
 =?utf-8?B?UWFwUTVHUXRNQ2F1NmhqU1ArU3FXUXBvd3JTUWxCZ2RpZEpuMGZDTU4yZDE3?=
 =?utf-8?B?V3o3dWRHczk4dVlmL0pYcmNlZ0treWcza1VqZVNZMFFPeUFURjZ3aXpFcHdH?=
 =?utf-8?B?VnNHQnVvalNqNFNzRFhibUVsdGlOdys5U1FOVzc0TDg1NGpKbHdzdDRUU3Zz?=
 =?utf-8?B?dFJvZld5cFV4eElpZE1jOGIyRlREc3poOG9ubTBHdHJUUHF1UEZ5Q3VxVlF6?=
 =?utf-8?B?Rk0xU0NnZGNqQzJnVEZLRXdrSzEweGcwcDlQcjZXQng4cXZQa2Y0NWs1eXVz?=
 =?utf-8?B?U3diZjl0MWs5TjRKVTBySm02UXYzaUt6aEFZc1h5aEJhcE13Kyt0RG1nN2hN?=
 =?utf-8?B?dUc3ZkVZVTZnQ1lRSys4czQvbld1cDZkOE9FOXd3cGNpMm02ZU5HQ1lDVTBE?=
 =?utf-8?B?bGJpUWtNcHlvc0FDRTNwRy8vTzRBRktXaFhyclFreXY4cDVJV1pjelpGaUNa?=
 =?utf-8?B?NXZuYlM4cXpHb01wOVQvdEgzOGJpdUwreEVvNVVXZkl2bzd2anBGdTk0QW5o?=
 =?utf-8?B?RHBvOFNnTjlPczNoVGc1YXh0L2EySUVtUkk0WkJTNnlJWkZIMlM3aHY3WjNv?=
 =?utf-8?B?NGx1Q3dyZnBXKzVDaUJlTkRoK3IzZ3pFYkEzTEtTUitIRWFhWmphUnhheXcw?=
 =?utf-8?B?SVlQY0U0RlcvVDB4WE9yM2I0a296VlViM1VzeHZFT2xVbkQ2Q0RuT3hHN3BZ?=
 =?utf-8?B?UlJWQXlqdzFTZ2JlbDkyd0E2MVlQR0w4Sm91UEg2SjZwOVBEK1BvY2szcm4z?=
 =?utf-8?B?dWNRNnZwTUdMdGk5aEFvVm9KZVZhcjhMWDRTeEF5WTVtTXV2c2o4M2dFbExD?=
 =?utf-8?B?QzFNSmRlTjJMZ3owVlpFazFDZ2RxUEpqTDIwMi9RYU1jemVvMWVGM1gzYWpF?=
 =?utf-8?B?b1hXZUMvQ1BBVmVGVHpQdDJzVksxNmNBRFBveG9RZ0tXYVduZjlCcVk0dSs5?=
 =?utf-8?B?aGQzRi9tdnY5Z2hZYSt5RWsxR2ZoNjBYNHF5SHN6RmVyTmJqVldueE9sZ1JB?=
 =?utf-8?B?aWVJeGk2cWkxc1QrQi9Ia1BBa3QvMDBXWnQ5WGRMbG1FQlU1anFmNmp6RGNh?=
 =?utf-8?B?MExmcW55OXdpZ0prSVQwWVFocGhmMllOWmR6alJMYlRHQ2tTaWpUMTZJUEoz?=
 =?utf-8?B?K1JQZE4wd2k0ZlFOZkNPTXZKR3o0Rk15ZXpkUTgyeXRJZDhYTDdteTBudjgw?=
 =?utf-8?B?Umc3YjY2OWhrZ0VFa09TT1kydHVhdmNTdWJSdTRIaTJDQ0NpYjhPcWdaZitm?=
 =?utf-8?B?VEp1OWpLZ3RWT2Y3T1hwNVVLNFd2bUtzemRwRkNwakpIRytWbUxaZzlxUzk4?=
 =?utf-8?B?Y3dTZ21za25jME9zZzhxbTI1VUNZcjJMK0FlZ0JoSFZHUCtNSU9KdFdYdzY5?=
 =?utf-8?B?UFJ6T3dUMG1EdXF2R0dxMGRNK0c1SlgzdDFCYlkrUVVSUmY2c0VhV2tXK3RJ?=
 =?utf-8?B?dzh2dGlhM2s4WHFOVDNLTExGWi9uTTBwL015anZsLzNoUXI4QVlKRktRUjJx?=
 =?utf-8?B?Y2ZXWkVWN3FNZlFYYzlvVmJaZWNhbEpueWxQWk5aVEhXYkxXc3lQUHZPa0hL?=
 =?utf-8?B?clQ1ZTBDY1lTOWlRRzZqRVpGb1dBaExCZ1Y1VjN0VmRLUCtsT2tRME9LNDNS?=
 =?utf-8?B?SGVyd0Q2MzJjSWNVZzZGMGJDZ2pQNkoxVGFqdnZVY3FydGRDRU8raDRMUXJn?=
 =?utf-8?B?ZE5kTkVWMFlNRkc1TUVJMTNjcnNQK2FPVm5HS1FQek80b3oyTmE1WnFkV3Fo?=
 =?utf-8?B?NjZjeEd1NUs3cGtjN05Wc0ZhbHhiVUg4RWVHMmZKOHBudDJHSC96ajFqNEFI?=
 =?utf-8?B?UkFha01CT3Z6Z2VzM1FVWkI0N1J0dHR3Q2QwR2ZRN1NSNTk5NkxJeFNFRUFp?=
 =?utf-8?B?SC9NTWxya2RFVW9kVExBQXhnRUN6eW5jMW9qTW40TXZKdWRZcjFwbUFubWln?=
 =?utf-8?B?eTdtRytxK3haQU5QTlU0SjFzRzlpZm5YZ0k4K3EvQUdKeGQwNCsyczJmaldq?=
 =?utf-8?B?SVNKUW1RK083bUx0cW1YOGwzVHV4c0ZqWHRPL2RiV1E3Ym9SR3VhMXY2bkV2?=
 =?utf-8?B?UE5VcEtoNkZqVWFjS0hJMVVCdHE2NXFoRi8yOEszMWlxK25nZWFvZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7300837b-9554-415b-fe70-08da18a51064
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 14:44:05.3977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fzv340sGSKOfwcoGizzfZ8oWxTU1rklkva7ulKv6nEvIfnb26Ien9QlXfFoLCXduuK71Cdu+QYtj0oJnpov02w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4857
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch merged to amd-staging-drm-next.

Thanks a lot!

On 2022-04-05 15:32, Simon Ser wrote:
> I've tested this patch and it fixes my bug [1]. Thanks!
> 
> Tested-by: Simon Ser <contact@emersion.fr>
> 
> [1]: https://gitlab.freedesktop.org/drm/amd/-/issues/1734>

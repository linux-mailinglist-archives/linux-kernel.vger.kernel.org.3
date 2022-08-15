Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D92D592CD0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiHOIdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiHOIdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:33:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56421FCE0;
        Mon, 15 Aug 2022 01:33:51 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27F4wGcu027703;
        Mon, 15 Aug 2022 08:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=P+5sR+MP2eJqpBWPXsoNM3dO9bqogEOd7kf31DBiAA4=;
 b=RnDNmKUqX5mbAPNudZvUvptJFrvO4sfO4bDWgoNLuVV1inZU6EqU5radCu8SpFxO9Llk
 Vo+PYiBkgonru2J2z2oywwYSZT1xoBIAgkVIqlvMc44iWlxPQrenXW+MOUPQvSi9tMPC
 n6CmYkby8NUV/JzJ8SN36RJxVu+KX7QRhKYV92PLHhbl1WvUrAPiRlOBN+LiH8pEne+T
 3oZg1jRzeoQ23s6bfs6/+bhtvMBro1xSVE+c5+Xj1bDcme2ofQ4kmFSrx7C3Bbpk5/39
 ejlR7KpZnSZv+/Plcy3YudpiPRXF7v2jxjDCnn01atx3pUh6kmar7VTeP/aiNnbR6WKK Dg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hx2r2ag2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Aug 2022 08:33:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27F8Ll1q022470;
        Mon, 15 Aug 2022 08:33:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2d77gx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Aug 2022 08:33:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAseUcNhuI6V9g+LfdXkQDqMHhRBScZWhY3gOyO4W+GXA7v/1FDeE5KqREXS+WuHFOcnT6W8o/9hPX/GQB9Z+397Fj6hmb5L6aarLuQwHhyr0x9djv8n6sb4+RDDPhUqILtwcEM82OmOh1/rsrWOE4X2ECjChdzpBD8LkmZpL+9RfxsECW3bX8oGbVaehsrJy4YnM7bBRUBVJt23TQ6yG04/obcqNMf36loSU2RcvEHc0J3NN/M44VxKhSbthKX6YdhfOX6fdyMlOw/fR53KCSgJahPZI0iwTHO+AB3YWFImKHAgkvSoSo2oAwEtVWKGSQqVx88wrS42HEHgnu9nfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+5sR+MP2eJqpBWPXsoNM3dO9bqogEOd7kf31DBiAA4=;
 b=CEM2rjvKu6wi/hwO5vBlDrg6kzQmOTyvMTpIv3/uqqYLgRVn9mLNI9wqR+oQ0c+RZZLpZNuBfXlIQos9r8VqqNI7aXLcvhrOTGwmDZalaFAgAYHkdshnMEyjEK6n15xIWKxsbiqSdZxMZBRtgSe1NZqPJ5hRHCXqBJ85VVYVdmPjvQdsOqPKvfIUwX7x4knnjeYmexYF5lNk+fnA1rzlRLj3vyZT7K8yOceoEJR/iiDQ98JKBfhc2XDD+a+2ZSi4lyRxgmQF+D/l3WiVpwuGqvlN5BKpeXpIqFincecwNwyMmmUZkpP3Gz6tpnfGCU/EEChlZMVAQ52LXXtZ9hSJdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+5sR+MP2eJqpBWPXsoNM3dO9bqogEOd7kf31DBiAA4=;
 b=L0tImvJJ1oqC75PqU8+C+B/VJ/e6DhmB8O7aAk4My28BaW4r9o4mGABhMRLVAYlV7Qg0/NjmvGgrDgUprXU361rj1ImcEJeO5lmU24o6FqhbNs0WAkIernvHsq9TgYxqpeQblB6Rb97DsDRFg+/ZGhf7ymD2//unYdWZqFoByaE=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by BN8PR10MB3201.namprd10.prod.outlook.com (2603:10b6:408:c3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Mon, 15 Aug
 2022 08:33:35 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9076:a11e:f5a3:dde7]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9076:a11e:f5a3:dde7%9]) with mapi id 15.20.5504.028; Mon, 15 Aug 2022
 08:33:35 +0000
Message-ID: <dae3f121-1a64-3b20-0e25-ffae724c0fac@oracle.com>
Date:   Mon, 15 Aug 2022 10:33:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] capabilities: new kernel.ns_modules_allowed sysctl
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Serge Hallyn <serge@hallyn.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-hardening@vger.kernel.org, John Haxby <john.haxby@oracle.com>
References: <20220809185229.28417-1-vegard.nossum@oracle.com>
 <202208091551.6879CADA0@keescook>
 <d4ded816-ec34-ae1e-b8ee-a7d87c924f1b@oracle.com>
 <202208121146.9E4A98B@keescook>
From:   Vegard Nossum <vegard.nossum@oracle.com>
In-Reply-To: <202208121146.9E4A98B@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P191CA0060.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::35) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11a06150-2ff4-47c5-953f-08da7e98d7ca
X-MS-TrafficTypeDiagnostic: BN8PR10MB3201:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nlDzB4JRSax+a0/TqnChB6G6BWegW/kHaC4lkT8ScfX/g3H/V0VoFasM9dqof22q6NtxEHkO3CdXlhbqSkG2m9qzOztRkv41vCEHP8ice04Z1qTgwWArEqEuy/e3a+jdzUG3ol6EgPscduDyGbXsrNOo9SIxfHNXhryHb0bi5PeTPvSG5hk44mjExdRRLVBRSfUALjr3TMuJOuFYTXi76oRC1tFkhmH+2jNT6TxfHb0uGcpnU7W5hL/xs78BzOYd9eFipBVT1/Cl6vgqyCqXKSqaT1lNxUBUvF+NAqxP/IetcLZXt8NaAhI8fhQm+eMautlOj8poaPSJPNN8EMh9VUVfW2fJJO1B2ltf5pbd6R+2zbiaOUW+DWMtyxN6r9jaStb+8+8m3Teg5TBP7qcUq5evAQY1U/Hu6Ub81JhUDpqPYw3rVQGBUMyuSnKUYKAvnfaM0y0NJph93/bc1gK3hRmNKH80Hp10vOytkNhyuPBFy7ptkg9GcgqJMo1VoFEBL60fSPDR4ynoc/jhzzX/pBu11CM/p7m/dVhuyB1NGfofUfhm9JWRCcsJkbEQ/lZDlToQA8iHrFz4tb7iAybS4HxxQWCfB64fsU1E4Cb0moWbqF000rbJwX9G1hfhLgmtNEMnig+3dipArwXIjV7c6Nr/gITjrJekMeGsOm4JfXTiy0aC7V+/ouNd+efwcGYxaTpwF0QY3b3O4QtJ2Wk2ycD5lR1pGTSN+PCuXnS48QZH/m9E7q927Hj8VQhAIuSgUCqcTdTM7yXhP0srf2zSAJK9PgLUy2JHyzYCWW89RyzlmqqY9u4imC4HQm0QFpuQ2CxQ/OcuS3yh9f2mZrpv/ungIR8uzLLR2DdaNfot/LJD/VhpeiQy/T2EdcoLhA36beUzG7+FDKZUjj85GcCizg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(366004)(346002)(136003)(39860400002)(6512007)(6506007)(2906002)(53546011)(52116002)(2616005)(8936002)(5660300002)(41300700001)(478600001)(6666004)(44832011)(26005)(107886003)(31696002)(86362001)(186003)(38100700002)(38350700002)(83380400001)(31686004)(6916009)(54906003)(66476007)(66556008)(66946007)(4326008)(316002)(36756003)(8676002)(966005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTcxbm1NQitEdy9YNFpuT0pjY3g5VitvbkxTTzVCSVQwZ0dhM21KVTVFaCtt?=
 =?utf-8?B?aTg3WWt3MEZ3VWtLaGlqNS84MGxFTno3eVZEb1RkQnVidjVMZWRtSXk0TkZn?=
 =?utf-8?B?MDdGNEtDUUdJeTdVb0QvWmpKRXV1Q0NWeUI3WWdRSnkxUitpWXNBTm9ESGhL?=
 =?utf-8?B?Zk1Fc0dlM1JYbmlLanB3cHNERTdzRUY0NFJycVBmTTcvY1dNdytDak1ENnNk?=
 =?utf-8?B?OUtPaXQvUURRRFR1dlRtajIwd3JHUUFVUUVHTyszS3dNTVdsT1pWVnB1L0RL?=
 =?utf-8?B?TFZYUnhVSjBCMDZEUWJxcFo5TUlPeExoMVlqREppWTY4aTVndmN3TDFQMy9Z?=
 =?utf-8?B?eWFyTGVYY2ZKdjNBbGhPTVl0WHZ2U0o1b3pmM0Q2OUQ0RkVramVXeTNSV1RP?=
 =?utf-8?B?ZE5nTW9KS1owQWVwbVVrdkpMNjBJeGFlL3h6bk10ZE41RnNTeHVqb0xNWFY1?=
 =?utf-8?B?aUtSZFJmMGZCT3pLTW9FWWxpTllUNXZzdVRNeS9tV3Q1cWhEaHpYWWdLWEl3?=
 =?utf-8?B?VTI1bHFEeDZMZU5QL2FlSXlyRFhVUzhkNzVwa3BLay9oK0tJWmhhSWw5ZGF5?=
 =?utf-8?B?MEt3bGk5QjRaTEtROFVPMllBa0djdmJVb1p4Mk5uemFMUVdVclZPL1FBTURj?=
 =?utf-8?B?ZHFsTTk5L2kwMnVQZnR1TUpYY3NBZ1lVSXUyMi9aRGtJSDRxdHY3OWRZUklK?=
 =?utf-8?B?M2xtQlZaNXl2L0JWcEZsUk5yQVkzbWwrZE5xYk1XTCs5MkFuRDdpUHpkak5U?=
 =?utf-8?B?cUlDWUVlc2dtMUMxbDNMR0hJcjFVMGQ0Z0hycDFVM1JYaHpZK2JHZGNlT0pu?=
 =?utf-8?B?M1lORXhwcUJhOW9KUWU3MmhUdHBaUjJNT091Q0RoWUdrb1p1TWdDMmFicmpI?=
 =?utf-8?B?VkppN25MWVVjTTFaVEtZNEF2TmFSbE83dkhJV1ovOS90VXBnUW1acmR6TlhD?=
 =?utf-8?B?SUt1enQ3dmpTOWxoWUZ6TklNaFk2TjJza2dUWjVOK2hKYUcyVCtaOTJ1ejZv?=
 =?utf-8?B?QTRuREhicUpJaXl3MjVRbVhCbTJOdkJMWDVacWZBNktyVys0emkyWHEwZVdl?=
 =?utf-8?B?aWVlSUtLVCtOT1hNMERMTWJCT05WN0hIeEJuUk13VmFsOHIzRlhOK2E4aUlt?=
 =?utf-8?B?NGN4Z3BuRnNFT0U1YUJUdjRWN0VrL1hubkJDeVdRdEx2cm9KNVhYNXlLWEp0?=
 =?utf-8?B?bmdJamFoOXNOQWo0T3FraXYzY3JXOE0rZWtrUFp2WUp6RXBJVzdUbU9QUnFY?=
 =?utf-8?B?SjRmaHBVQ1FaYlN2UWJ2bXR2TXZvU01EakRDcW9UOFM5Q2Z4aGc2K2t3TTUv?=
 =?utf-8?B?SmdZOXdCNGhYZVY2RmZOTDJiN0czOHkvYjFWNVN0VG5TNzR5SU5mV1Baa2Zl?=
 =?utf-8?B?Um1oNHZacnpBZHJoZnhZZkd0WHNlaFlveDZHOEttaW1WcWJqNGJsSkV3QU9i?=
 =?utf-8?B?ZFNnMVlMWFJGREJDWXlzNXQxMDVpOE5iUU9tSnFETklXM29YTTh4djNXRDQ1?=
 =?utf-8?B?S2x3a3dPS21aeTNtY3NGVGJGYnlZY3Q0R1ZkWjhUV3BoTzQyd1BKVGxLak1x?=
 =?utf-8?B?L0k4dTU5UTB1MmFJbDdPMklyK0xzUjJLc291SjZRcEZWSmxtUnVnYjNPbWND?=
 =?utf-8?B?UWtnMjlacytXaHBuM0xETjBadC9DNXhycUFUdXVJVTNWa29pMFhiQWxROGRW?=
 =?utf-8?B?bFZPeXRjeXh5SHkyUXZoK2pvYXNPNytwaGd1WkZXSDRHaFU3Y2I1YkZ5NTFZ?=
 =?utf-8?B?SitNVkdKdU5KR1lnWUtBMXAzdGg2eHhzeDhINm1VRXZHdVBIdkdTdjAweFU5?=
 =?utf-8?B?cVUyZXRYeHh5eHBaU2prMU5kL0lMTkVuUDJSZkRCdEFkcEF0eEpSbklhZmtE?=
 =?utf-8?B?dk01eUNqcTZYNWVNWDAycW5Fb1U3NXpFSDgrMzJEZVpUZnBYV3B2RzR3RVQr?=
 =?utf-8?B?RFBKRnZ6TXVBNHRsYzJtckJBS1dESjJ0Y3hJR0tJMTZPOUFzY1g3Yjhqamc0?=
 =?utf-8?B?aW0vRnBOQm42VmY2WTJQZmJ1ekpwRnRIN1BybGg4WHJIMTByZ2NhcWtKRE1Q?=
 =?utf-8?B?NzNnNVAwM0NOYUFjRGQxU1dTdVY5cElLa1RHcU9OUU9RTktZd0ZWSFpIK2xY?=
 =?utf-8?B?Z29wN3NBYUxtSVJtdWlheFlNZGsxV3RpU2JRVjBaU2ZmZU1GSlZVcGM0Rzd3?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cnlFZnhLU2h1bVMxc3BQYVZ1TG9scW5ENUZwa2pHdFF1NnRlc3BQNFdtN2Fj?=
 =?utf-8?B?cFBGK1YwVnlxYlphaXhpdm9VZmd0S1h2NGg4czVaa0IvTDhPUWxDZkQzc2ll?=
 =?utf-8?B?NDVyaDVodE12L1h2Q2lVSFA0WEhCUWFJN3I5RElOeE5udlg2bzVYSDBaYjN1?=
 =?utf-8?B?M2VQeENkZmRiTWRWSGNaOHVCblhEVS95LzdxbU8xeDdocDFwQjRuZ2tlZFFM?=
 =?utf-8?B?UUVNRFBEMW9kcTEyY0dWV0UyNi8yZUR4ejJVWUpLUTBCMnU3WkhxQk4zbWFQ?=
 =?utf-8?B?eDFLMHEvWEo5V2xneTlHQ0xJdS9FRHpjbTF3WmxsMnVBNFhBeSt0TWMzZk9O?=
 =?utf-8?B?U2ZaSDVJSVExWGhYTzlaY29SbEtUM1JaaWZDbjY3Y04rRzA5aVVyVHZWUUVR?=
 =?utf-8?B?c2YxSkgxYzlVUEhLSEMvNlg3NG5uOTdRU3VINUEzWVJCdUxuQzVqT3hpaDJD?=
 =?utf-8?B?RFJJR0tKR3pVSG5pRERnaWFXQXBveHl6cVJ4MGVyRWxMRC9uQmtQbnhmOFZj?=
 =?utf-8?B?NExQV3B1bHppeE9UakVhaFhNNkN4U3loa1ZXNGRVSm80SVpQYWdnaXdyd1NT?=
 =?utf-8?B?dDd0SmVTWEpCMmFxMVJKWDJGZFVYeTUzWE9IVVNvcmRtSGt6aGEvWkQrQzRF?=
 =?utf-8?B?d3lyQ1dvVmJmbUtmd1A4U2ZXcHBiNlU1WjhEODBEcDJhZHREb3VuVXo3MWVD?=
 =?utf-8?B?M0x0UHZUY3Q4YjhmUmU1bEFmNy9hWFJlRUNPTjZmTXo1aUtTblloeVh0VGFZ?=
 =?utf-8?B?Qm84ZGFjQmhaNUhwWk11M1IzaEJXNnptSlY0UzZWZzNQcHZBVDZKT3JhRTZu?=
 =?utf-8?B?bVFON3ZRZ29DSWhKdGJncCtydG84N2ExWEhROUdnWmdOVVBuZ2lmNExrc2xB?=
 =?utf-8?B?RGRGQ2RyN3hZMlk0K0VVMXl1ZGdoa1A0anlaeVo2Skw3U3hQNzZtMm8zYmVI?=
 =?utf-8?B?QlZyRmZteU9RUlMzbmRzQ1V6eS9uZHJHNk0vQmMybHFpRDM4UVNVcU5UWTZm?=
 =?utf-8?B?OWpvWE1FNks5OG51YjlQa0huM1VPSjUvaDJ0Z0Fldm9wR1loK0hZOHIrb1BV?=
 =?utf-8?B?RFptSjFPOWgzWGhibmoyVU1zSmowVG5jNGQxWEE2dTh5VkJHTVMyWGdKNW9a?=
 =?utf-8?B?eno5NC9KTWFpSW1kaDlwTlRGb005VGxhTG9CSEFMdnZ1VHZpaWFzR1FuU3hX?=
 =?utf-8?B?Y1Q2UlREWDBldTFzQ21JTHRrVFc1d2lPNWFsL3FFMXYrUG92SXZTYnY3SjRh?=
 =?utf-8?B?N1hYTm9TTE81S2daVWpxajRNMCt4cFlVdE1wSHhpd1RlbTNBVklnWldueXB6?=
 =?utf-8?B?NmdpS1c1Y1FxblI0QjdrOGRQUjN4L0hZY1Rqd3JqUHd5YnBlWG9LWnBnWXBD?=
 =?utf-8?B?dXJueG1MNnkrVVE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a06150-2ff4-47c5-953f-08da7e98d7ca
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 08:33:35.1070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nb7Xk22FWHSA2jG6y9+FRCqTQXDTAbXVZ7siKKiQNpefyaUIZIq6EncQ16uC29g8u+r/BzEYqdfr6Oc0SVpX1qUcrSNqm6InJD/TWrE7aoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_05,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150029
X-Proofpoint-GUID: ftuFnRaKKrVf34LMHkMS9pL5-uQe9p0r
X-Proofpoint-ORIG-GUID: ftuFnRaKKrVf34LMHkMS9pL5-uQe9p0r
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/12/22 20:48, Kees Cook wrote:
> On Wed, Aug 10, 2022 at 10:25:17AM +0200, Vegard Nossum wrote:
>>
>> On 8/10/22 00:56, Kees Cook wrote:
>>> On Tue, Aug 09, 2022 at 08:52:29PM +0200, Vegard Nossum wrote:
>>>> Creating a new user namespace grants you the ability to reach a lot of code
>>>> (including loading certain kernel modules) that would otherwise be out of
>>>> reach of an attacker. We can reduce the attack surface and block exploits
>>>> by ensuring that user namespaces cannot trigger module (auto-)loading.
>>>>

[...]

> I agree, it'd be nice to have. I'm just trying to predict what kind of
> push-back there may be.
> 
> Can you address the build failures noted on the thread, and send a v2?

Did just now:

https://lore.kernel.org/all/20220815082753.6088-1-vegard.nossum@oracle.com/

> I
> note that after this patch it looks like all module loading from a userns
> gets logged, regardless of the setting. Is that intended?

Yeah, I thought it was useful to know even when the sysctl was disabled
but I've removed it in v2 so the patch is less intrusive. I guess it can
always be added later if it actually serves a purpose.

Thanks,


Vegard

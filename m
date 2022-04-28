Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB46512815
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 02:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbiD1AgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 20:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiD1AgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 20:36:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C76B3A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 17:32:51 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RKJXOq015535;
        Thu, 28 Apr 2022 00:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=r9VyRD/Ec4YELG53ABHqu1KJGh0dRhfNdWG2icQKs8o=;
 b=fBm3KQl052W3MwdUpGIq0jHxvJRCRqZWYkqRMgHH3MocLmlUSQnohtNJPoa3IcL8CZ7R
 wMGpmfxDD9vszDpo6HJvdUDAhCs8uEnMrlKDAhu9Q1+FgxVaNn3m1aWtcGJu2E8FGfkO
 xvle84nTLza5X/g/6BY+VtIC+x/PMpNNO37uhx4IE8TY4HtCwFV3Dw1MLTN3Yj9l3UiN
 d5/QYSoUXivbBm3NfNqHeueth3hcYuhZgCAV5QPPGmGdrZNdvpn14LzaSBurm664U999
 p/Tte6Jx+vGLaPQ5d2ZLhYnGs57HxDYQ+5Gydt1hUMwyQ3ZswhxXCCN3byMBAgnzfgQp gw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9athhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 00:32:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23S0UeQ0037618;
        Thu, 28 Apr 2022 00:32:34 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5ymv8j1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 00:32:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGDEBdZ1Rv/RdB5eKkrUPb4DfeUO7b0UOEXPHAnbWXFFvJasRQWkVeLTMuTlNYEN8HRColdfyiE3dHHtWjirU5dVMGzdmxhGn+ly7K6uJqUB0GjhSCP6Ult+lyoK73xpk4lTcHnjSg00BNBnFc5CYH5pktUHZT0XtNPKjBH+m3bDIOAS3aQDk++sBCFtbnDY9b9Z+qC+ZBhvLW2fpAYsZ5yhVpXLx35UT68PWE3myUmoj19Rgj+I4yimW7jL3JuenXVdfbCDq9nXOwV0/E0LTHyAMbLLRVLdEjsMiRdmHu9GtXhgaJDvLzboWwXi4DXnzRU/KIWdTb55G7yZBlVrsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9VyRD/Ec4YELG53ABHqu1KJGh0dRhfNdWG2icQKs8o=;
 b=Xw3yRjnd7dyyTsQF21Sz1auE3Ywl5yMmmB81V4948V4ho70apB602wfXnwmyzLBtqK/HebNaVwcabZRj0W528Qhdmo42OUcLIWobguHTskRPfGtqAZWOzX6YChQenKRBfRUmqooTgKYt3HkeS5/yncObhnS1F5djlB18pdAjOrFbGVuxXym53XZF4R3Dfi7KQGXNe35dJL5H7s/uldTh78DqBq367ZNZQDF/CwmbI8jP6gL0SdqNngk6jIdn1gS9BxUWpMrUNpo64YEfJuGJts9AKsUAFRn/OL36gI7HTt9/CpdV6b1BGjkXS8B3w6T+PsAiRqJQmTOwPirfNr9qVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9VyRD/Ec4YELG53ABHqu1KJGh0dRhfNdWG2icQKs8o=;
 b=Q0P88a7NxDKVMJ6/lTGxIrny6U5jUXMpPtuONoNsu3/JAMUwB9mM8putgemb0mLE+qmzVhbMWrBmHQgKGC24qUIZtpg0V0N3oEjlfgNrmh3DtxYSuginR4rYtPUCGGCX1Q5q4rDjC3NO/QWYsn3rah6sX8i04sAb+RzLOBg9Qo0=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by DS7PR10MB5198.namprd10.prod.outlook.com (2603:10b6:5:3a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 00:32:33 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::4427:92a2:50a5:50b6]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::4427:92a2:50a5:50b6%8]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 00:32:33 +0000
Message-ID: <df14f805-b4b5-9cc8-dd71-9d07c79ca15d@oracle.com>
Date:   Wed, 27 Apr 2022 19:32:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] locking/rwsem: Allow slowpath writer to ignore handoff
 bit if not set by first waiter
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>
References: <20220427173124.1428050-1-longman@redhat.com>
 <cd1da3e3-9024-2c97-3343-2569f74018be@oracle.com>
 <eb02c830-e4ff-c1a3-f23a-0ff7b8854acb@redhat.com>
From:   John Donnelly <john.p.donnelly@oracle.com>
In-Reply-To: <eb02c830-e4ff-c1a3-f23a-0ff7b8854acb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0290.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::25) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd049386-9947-4eb7-4e39-08da28ae95c5
X-MS-TrafficTypeDiagnostic: DS7PR10MB5198:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB5198F2594212FCD0E7DC1C87C7FD9@DS7PR10MB5198.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MXgDeki4L+kGd+mpgLvvWpNpEq0sqoMm2ZqdT5ZU+fTGs5vb8gyNPshb0H6SnKLXr4G70R/Q124nFiXV2XZ0BeD3hGiHI74j/MOpwqhBAW587YiWvCS7nPdAWMUe5t9XEnR8jkm3wycZn5Gk2O/C54yXJcmHO2W+dpw6x6zbu+bDRLzIKj8NRf8fC+SNMqvVKkKcLQ1JKJU1rkq5eTe9Ll1flSSJvEamY5jZ3MxfECs04O5d1ET0Ss8h2B4XOen8T7DlDiPqiZU0SYLyTLInQ9zj2gVt8mCi5b5eZX8qDNrt2NfLEHeutldrfzvlxRBsM8yq6a6JAndmFGX5NylB0sRDrP0laTITVl4kUYwm/Wb1F3Yfd4e7lTOMzTFVUJBfTb4qhEdMffv2xgbhBgyLX/2EE/k+vTvqaCMvY1ex+MCg/zrJDgDSxZnwpmhfxh7ZoA0/zgycnRiD3hcS3qijzkxUyGVOZfG7+lP1c+CTHDyBnZnMdTa0VPmRN1mAqIT38Ct3JU2HUjD5GOAeXQQ70nNpZQOyTbrn3srl774qjqtzsLJkdqNqO+rTUiBFb99wZQFO09XCMMRq2wCYGxshuDbTKEuhdkgSflzSXutpPn7ARvqZa6230F7BB0TiFyxm3Wd9jxhjfGAuhFMsStQBE4syasU0ggbrgait65YY7kj7QWIHs4jXjFCdDjqy5Y2DUroTLp10Q9iNZNrTlEq8YsNzP4GI9R7rC/alewab9zmvvQXcC2A0rXYdq7aZ+Kk2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(508600001)(2616005)(86362001)(31696002)(53546011)(26005)(6506007)(6512007)(38100700002)(6666004)(66476007)(316002)(2906002)(66946007)(66556008)(186003)(5660300002)(36756003)(8936002)(110136005)(31686004)(4326008)(83380400001)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEdmUzF3MU11dWVDSm5OT0xKdWh2QU1uVzBEd1lWdUl3aEJDSXp5Q2hFVHpZ?=
 =?utf-8?B?Y0liaWV4Zmt5VURBYjJSZTVWNURCS0ppOFd2bXNQZE1FaGF6SExhSTQrRm9Y?=
 =?utf-8?B?L0tEWU9iUTBYNTdidkV4bTZRaEVDNG1XelBpSHliY2x3VVlpY2ZwZ2JralRD?=
 =?utf-8?B?b1dOcDMybm0zbG5tbHd1a2NpZzNDMVdnMjlQM3FEVnQzazYzbmVDcHBtczFW?=
 =?utf-8?B?aEZTb0JsU1p4M0xvMWFnZy9XaXhkbzF6cUx4VE0rMjRqaW5lOWphZ3NzaG9o?=
 =?utf-8?B?bTNacVVKVE93NWFwazUwZThVV285RXJSMkZCbkdISFlEcXZjOG9KeDVGZnpQ?=
 =?utf-8?B?cXdaV01oeDZKYnl2enRSWkRYYlRQdE5lMWN2MHg1YUxZRnJYc0dsd2dWTWU2?=
 =?utf-8?B?b1ZLVis1V0FYVTlSWDlXVTRYMTJJVWVTVzB4bEsvbDcwbTQ1TlplR0RvYTlY?=
 =?utf-8?B?R2JHeGV4b3ppdWJOclFST2tFdmF3RlEzaW5BNWh0S0Jpamc2MkVpOVZrWndY?=
 =?utf-8?B?VTJRU3lnc3pQWUROVy9tcHpsVzliMEMrQWtyZzJWaFY4U2pMaEpEZUFHWnhF?=
 =?utf-8?B?YTRkRklMakVsZEVjMXFTcW9oOXZhUldrMHZ4bmNKdEZmY1JiNmdWRGJ0My8x?=
 =?utf-8?B?dW1BbnJ3eWRnYzhsVzJHclEwYVM1QTltNUVCZXIyOStUTXFzdXhDYlpUc25X?=
 =?utf-8?B?WmtORVNEZklScEMya1dTV2xlOXp0d1ZuOHlBU05ONG9Mem1XUmpXQjFVZ1dj?=
 =?utf-8?B?N1BxV0gwVU5HSHFDWnBLQ2dkejkwVGs3VDg2ZWZoa1ZkUEJoWWlDSFVwQzR1?=
 =?utf-8?B?aTA0VXd3bVJGVW9SL3JYa1BLV3RRRmJWSll0Wi9JTU5iV1dFeTVsS2xscS93?=
 =?utf-8?B?OCtSS1RLZjRrelRBS3U4eFBzN3RkUTF6eEFEYXIzODVtWklDcjM4L0dVejN4?=
 =?utf-8?B?TjBOTTc0dGNuTURBZVMzZk1GVDFGZC9wc2ttNnVtRWtJSEpTcTRLcW4vOFFv?=
 =?utf-8?B?bkk5SjZGVXE3bUtFSWliOTBkamJZdm50RUxveVZkNkRGdTR6eGhKUXJqM1hl?=
 =?utf-8?B?NGxScENSelVMbVIvVDVqTW14eDRsS2tiU0ZnZDVmcDJzcDM4OEpYelI1K1U5?=
 =?utf-8?B?cFZDOGdhNVlFMWtVUWNPQytNMGRlVlRXZ3laWDZ5cmRmTkZsRHdTQ0F5bmZX?=
 =?utf-8?B?UkEwazZXS3M1cTZqT2pxV1htaFlGSVROMU5hdHowMEZCUmZrUXl5cXBwSDJH?=
 =?utf-8?B?cnh0SGFwOXRXZER0dmhnUG8wKzVkTnY0bTZ2NFcvb1FmRGhvUHJRUzNhNG4x?=
 =?utf-8?B?c3N3eGFhZGFibVhKUmJ0VUVzZUFQMFFwWUNHSEJGZlNGakNCRFJtTzdqMjdo?=
 =?utf-8?B?Qk5sU1MvMDRqRGRsMDJNVEh2Mk9hMFVpTEljaTZXZ2VyaDRHNDdkZHZPcjFo?=
 =?utf-8?B?eFRkU2llYzZnR0NScS9jMDNQSU5nejVpUjFnYnAwdHRrQXJsdEt1ek85VW9C?=
 =?utf-8?B?ZHp0MWVaSEc5eFVXZlhxSjNPUEV2MHNjdVliK3M2Z2tNUzNCTm9UaGtaYitJ?=
 =?utf-8?B?RkVKUVBlb1lzaG1BQjF2ZERBZytldzYwUU9Vd2ZVZDhBYXZsc3JTOFlGYVdx?=
 =?utf-8?B?TXlRYWtOT3BMT0xnallOcExYY1F0b252NzdFOUQwaVZNUFAycDlXUnJTQ2Jm?=
 =?utf-8?B?NUU1elBpLzRjc2F3Z0MzdmV4Uk9LYXNGaE42Y214N0IxWXBQQTlqTU5za2U5?=
 =?utf-8?B?M2kzcFZ5eTFudWJ4UzhiczVCcnNHeW1xdlBCZGZlMm5KSDVXbk9kajdCOGQ4?=
 =?utf-8?B?MVBjTVpIUUREL0FRV3RJUS84NFkrRGVueThwdWNPTVE1WkhWZHNZTmMyVDFL?=
 =?utf-8?B?RGtaMEFURG9hSnN5aENjQUlOT0lpYU5SNk9sKzJMRm8vNWo5S0twYUIvTTBK?=
 =?utf-8?B?NWk1RlNVTyt3Yjlwa0lvM0hNK294YnBDRE1WNlNDL0lsZkFieUNwRGphUUI1?=
 =?utf-8?B?RWpCQ2hVbUtFSXI1RXBMSloxYmF4Nno0SFlqd0lpdnJOdFdhSWg0UUVLWFdv?=
 =?utf-8?B?MzJDRi8vdlV1NnI0Ti9OdTNscCtpNnBITnU1NGdRblBzZUtRSEQrMzVrTm85?=
 =?utf-8?B?Z3dXQkNzNFRFcEFYK2hmb2EwN2JpNEpKVisyTnYzUlRnK29JRG96a0dhYmlX?=
 =?utf-8?B?NFNyTWhmenJlcSthZm9qeG1YV3J5QnZkdHNranJzdndSVVJPUVB1aml0Zndk?=
 =?utf-8?B?bWhzVms3b0dRa0Z2VUJ2Lyt3Smw1WGNmZXFvYWlvWVAxUktnZSt4UHB4dVk2?=
 =?utf-8?B?dEY2bGxlbVphTDd3SnIvTmppQXNSQUlRc1FhUUczQ2VlR0EzaFA5UXlWRjlk?=
 =?utf-8?Q?NeGO0xbflaix/4wg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd049386-9947-4eb7-4e39-08da28ae95c5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 00:32:33.1471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3otIZBdRTHRu0htf/A45kU4zI7pt3yFCswNdheFjFPjXaJte/aqZ/KnoEV1p3PTSHRA4R7zVKIME8KPvNGO4AqE+dpD20eOppcdFmi8aW6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5198
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204280000
X-Proofpoint-ORIG-GUID: jGfq7fkZJFWWQqx9bljP39vI-_XVU9DB
X-Proofpoint-GUID: jGfq7fkZJFWWQqx9bljP39vI-_XVU9DB
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/22 18:56, Waiman Long wrote:
> On 4/27/22 19:16, John Donnelly wrote:
>> On 4/27/22 12:31 PM, Waiman Long wrote:
>>> With commit d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more
>>> consistent"), the writer that sets the handoff bit can be interrupted
>>> out without clearing the bit if the wait queue isn't empty. This 
>>> disables
>>> reader and writer optimistic lock spinning and stealing.
>>>
>>> Now if a non-first writer in the queue is somehow woken up or first
>>> entering the waiting loop, it can't acquire the lock.  This is not
>>> the case before that commit as the writer that set the handoff bit
>>> will clear it when exiting out via the out_nolock path. This is less
>>> efficient as the busy rwsem stays in an unlock state for a longer time.
>>>
>>> This patch allows a non-first writer to ignore the handoff bit if it
>>> is not originally set or initiated by the first waiter.
>>>
>>> Fixes: d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more 
>>> consistent")
>>
>> Hi Waiman,
>>
>> 1. You likely need :
>>
>> Cc: <stable@vger.kernel.org>
>>
>> Since d257cc8cb8d5 has been migrated to other LTS threads (5.15.y for 
>> sure) .
> 
> Since the commit has a fixes tag, the stable will automatically pick it up.
> 
>>
>> 2. I had posted this earlier:
>>
>> [PATCH 5.15 1/1] Revert "locking/rwsem: Make handoff bit handling more 
>> consistent"
>>
>> That is likely not needed now.
> Right. The patch was created to fix a problem reported by another user. 
> So reverting it may not the right move.



Thanks for the quick follow up.


>>
>>
>> 3. Please add :
>>
>> Reported-by: Jorge Lopez <jorge.jo.lopez@oracle.com>
>>
>> We can likely test this, but I can't give a ETA when that will happen.
>>
>>
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>
>> Acked-by: John Donnelly <john.p.donnelly@oracle.com>
> 
> Will add the that when I send out the next version.
> 
> Cheers,
> Longman
> 


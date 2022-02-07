Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD93C4AB600
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 08:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbiBGHnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 02:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbiBGHeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:34:20 -0500
X-Greylist: delayed 824 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 23:34:18 PST
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E253DC043188;
        Sun,  6 Feb 2022 23:34:18 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2173cNVm026188;
        Mon, 7 Feb 2022 07:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=8uPDqEbXe6m4ARfk72xhB5ouODlhboPAvJi0E0hoIFM=;
 b=iab3eE3oqNX0+Ayprmm2qNIVuI3kIWxW2BE8UnR8+B627xMnSn49V54bWW11avdPuw8N
 /G94VyltimLDYfLviMlrAPZ/hnnOaBSE4JtQbyMoTrICBwAYvLzdahWXIdKf4Ef8Onus
 w78ud4fJqRO/eeTFov8DV8UgcGVvCvUi/xXykZAesSEGH8aJLD5KB2Ns3VzWf5Kbl9Ie
 Rn4XevnXwcfutgVHWLIRpP++ZdDcM66SzQFyJ0bOueZM/KPWH/StCSF6PKkzi9ofc3vh
 /Om9rx2cXU50GheW0mKZeY6pYm3DzkpdI4GoI6cUOxxHnx164HeYegZQwpGOUSiJqjZt Fg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1h4b4vtt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 07:34:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2177FTDk065556;
        Mon, 7 Feb 2022 07:34:11 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by aserp3020.oracle.com with ESMTP id 3e1h23wk66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 07:34:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZIQY0PUb3a4UQaRdtOufujLgKFuNYNuCmMxgMYERXRKcVxYa+6hHmOY/qGylHvTLwin458S6V2u9V4OYDs72PBakgaR5g3hAqrwvzfaFaNVy/mqRL34p+3/HejRUvBPpU65YJsA0Me7KpAV74si7RUEeLeqvp2o/h+Kbc6GMzyEG4AcI7iPowbSCreoWfBO6e1cGSrmvpnrm7M6ZTdB0O4s8Vl7tfINSU/e0nTpop8YiZtR3wZGjmm1Khj4ffQf8wf2WoEmH2nZTdb8VqFfX7GBK465i58S7nw50LRrAK+OF1A4w/DUpC71W0G6Gp+LxJw3v1GSQHnMzffx9LqIAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uPDqEbXe6m4ARfk72xhB5ouODlhboPAvJi0E0hoIFM=;
 b=Je3hJNwFavZDlH1XNNzdvmT1dwWj9v3NwH8OLLl4079C/O5Pc3kSaOk4QC/xqM/fxA5OHYgR0DqjDMRd13bH6S3dDKn+QKt56w9ICz6SwIm79jFWaVWe3vSoSogPVZnqPYiMg7eHLp1FgrbP9yOq04NFueFdo4upKCxaSWTEczJrYNIC9J2IHly1SzbC7sUtfrXiDebxUdj1spqHWVqfVkOhT8XuZdU0ApkqqYr5HRQOTPVAtXaNPRB+2vZoBDt/lnLqBAgO/vRNABgQLS3xpHCjjkD6ykKt63uTeXbfxUmBtthj6VdT55un/ixx/DyNhTk/H3BTDZ68VnzWKEr+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uPDqEbXe6m4ARfk72xhB5ouODlhboPAvJi0E0hoIFM=;
 b=BdmsWH3kC8CuUWSsY/2xE216ky/d5Z7hsBdnaLdP0AVrJlym+MMVIdh4DCIJQ3tHUfGHalv4Y4pKczeOgkRpzvsNmhvQoXN3chddNpan6OxRylV7Q3FbdseqTaPvXUsu9FQ62HqPtdCszycvkmr3SHLAORyIwXshRQcBFkIzTSo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4661.namprd10.prod.outlook.com
 (2603:10b6:510:42::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 07:34:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 07:34:09 +0000
Date:   Mon, 7 Feb 2022 10:33:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] staging: wlan-ng: Replace one-element arrays with
 flexible-array members
Message-ID: <20220207073350.GB1951@kadam>
References: <20220204233015.GA454979@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220204233015.GA454979@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0010.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a30a6c3d-c8fc-4575-d77b-08d9ea0c3ac9
X-MS-TrafficTypeDiagnostic: PH0PR10MB4661:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB4661712092DF0A7BD9B294D28E2C9@PH0PR10MB4661.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sd02U60/UnzE94Wp23rYPGCx/HWPlwYDAYC5RryEj2JqdAJf4gKJ4mJHlwPIZrerLUdbZexPGs23sQNrrwU5onrZ6MAYKIoN0WCZbBGKBXGRlB9UeDnA8Od0lrYOfGcPrY7PdruKPlyprLJJXkYNBstgMlgIlfHV3L8iNKJ0cXjV8IMWUhkPWfazSKFj/Ry+GnVX7mjNUs9pk6wtuqeuz7Sa4EcjRByd7ADz4YFAMmXL5QILGo+SifU/1YlBoW2NV0FIfTJxUFjEuU4E4Y4C2cK8f+Vgw4YUGgHO29Q2GqR4hrP86kN9wqmMRRI/YfcCYsoYOZfi9d900EDmjrJfkfPuUonULXa1xGE0w+TldLWjRme7YKqUMkoBCBrMcporwHm21xs8418oiIgbGUrer7IwAx1og41s5IwhVWX7cempEcf+vQiZxJ3Agl81vfulPBTsJnVAW+XYHgpZX9HQBbOxSasksmEAivqp0lskAOsdAUdyPkiAUv4GdwihdZqbRjYzWz3VT3ipzTxc2FPLOJwvt/42oo5a4AiRLjK+Pog5y1/mzv/3JAP1z43jiezxd9cmjg8++XvTHguWB68TD8ywvohXOZdI7i0Mf4L/go+AESfnqtmpJ9kAkG/ikn5hIadGQ5SPDAKfpbkA2pj8Qj0UW61sMyr8dm4qWH+SNDrL6SBaJSYmFmeBj9CyafGx/hH+5CzJG2ioKqWE2XjXww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(66946007)(33716001)(38350700002)(38100700002)(8936002)(8676002)(66476007)(316002)(6916009)(4326008)(66556008)(83380400001)(5660300002)(2906002)(44832011)(6486002)(1076003)(6666004)(6506007)(508600001)(6512007)(26005)(186003)(9686003)(52116002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFFLVDdTNlAwSDNXeTYrbHo3MGk2NFM4NHVtS1dIazVIY0szNnBPMXVjZjJu?=
 =?utf-8?B?SEZBK3F4TTJUc2ZkMVFiemVKOUwzMU1mNW03T3pSVGRqcVpNNHNweTNUUzdF?=
 =?utf-8?B?bFVYVTcxbGdwdkJwQm5qU0cxTXJOOUJ3Vm5zVzBEb3JHWmc1MlVIWDhsSllN?=
 =?utf-8?B?a1puS1QzNHJLMTdHd3hHQ2JwZFc2aGdlZndKUTlKeHpCSkl5VDl3YmhQWkV2?=
 =?utf-8?B?aER6NW5veUlUMGNRVXZsTEFGaWdPYlNlOG1NTHRlemlYUWRuYXN5cStJc3I1?=
 =?utf-8?B?Q0V0TnNBWUo3OEZOR1IxV1BKMDlWQUpqc24wMlVCd0VPdkNsNzdzRlJjTytK?=
 =?utf-8?B?V0ZoZVRCYXJOTHZGeGZCNWdMY283K0hJNFhySVp5cXdpUWNiT1BCcEk2bEoz?=
 =?utf-8?B?amNQTlBBUElVQW1sSzJEL0htRW9Uc0FXcWI3ZUlvaTZEcUQySnlUNGpicWJo?=
 =?utf-8?B?bml5R3pYaE95akordVFqVjVrY3RjR3M5eWNBVnR1V3IvMlpxcHNiQXBUOXFw?=
 =?utf-8?B?d2NiQ3dIVmZHYnNPY05VQ2FzZUx2VXk0U1grMklqanE0U0Q3NXcrUXpIY1k5?=
 =?utf-8?B?aHdXRHlsbTRCRVpsdHNVZGxXNVp5SnI3dVM0QkRFc0pQWU5TRElUcHFmbVpa?=
 =?utf-8?B?ZlY5b2pEYzFXOXdwS2pncTJFYVJwRVh3UmNZK3VscEw3U3I2U2RWOXphL2V0?=
 =?utf-8?B?UjFGdUptZUlYS1JyZEtQU0x0WnR5ZUsvNWRwMGpCWGEzQmRIbkZkb1RjaXhQ?=
 =?utf-8?B?UU1Ub2xtdlc5OWRyM2g5MTZiYlQrbEdXWFNORFMrcTI4QVlFVkM1bUdWK1Ry?=
 =?utf-8?B?WlR4R2dvUkl1WWFtRkdoNmFqajRzNzdOWkNaT1owL0hrME1hdk5LekR2Ujkr?=
 =?utf-8?B?aU43ZVlRaVAyWVBWbkNxTmsyalo1WnVCdWFwTllzZWcwbkF1TFhxUXNLaVAr?=
 =?utf-8?B?TEpFVU5kWGhpaVFsNXEyYUFvdG5Kc29NTUhrdGt5czhFSXZRYk05RXVlMXlh?=
 =?utf-8?B?V0d1M1Zrb1FwUkF1U3dtV2szL0NUQmhNbGk0YzNlck15SUZ5bDVOM0ZSRHdv?=
 =?utf-8?B?Z3NmS3JYQllpRm12T3NUU2hTdmdsYnhBelByMjI2d0lZZ1VBYmdvb1VWYkZW?=
 =?utf-8?B?cGxERGE0R1puRTBHc2dPTXVxMTg5dHZ6WDVTNjU0cXd4TERHUkFjb25YM0x4?=
 =?utf-8?B?Mm1YeXNEczdYL2ZVQzBPUDJZZzIvYmxTN0oxRjJuMnlnZ2N2bnpvNTg4RVEy?=
 =?utf-8?B?bENnZEs2ZDF4UXo0N3l2SndaYzVMd3FzdXlEZkNLN2FOelJvT2R2K1JUZGNa?=
 =?utf-8?B?S1VTbXgxYzRuTTY1eGhCWmtCYTJ4S1hiaVFPNTlLcUUydUtNRmxSREtoMS9J?=
 =?utf-8?B?M3MyUkYwNlQ2LzN0OStDMGZTNEQwajc2NHlSZXFjOS9LWWFXYlhoc1E5MERM?=
 =?utf-8?B?RG5hZjJZM09tWVgrcmNXL1RTQTR6M3FGUU1XMW04UHV5UkgxNDg2dWtCOVNP?=
 =?utf-8?B?ei9Ld1dVREl6dWEwbUIra0p1cHRuejNMNm1FOFkwTW56UjYzR0VYNmNtUW54?=
 =?utf-8?B?bGNCL1orSXk4SGxsSU80c1U5a0Y3eXBnNS92aXFoU1NzR20zWHEreXZGTy95?=
 =?utf-8?B?Q3I0akZHc2IvbS9KbjVNRUhDOG5rUlZYMkNoZldXUjF4OTdWQ2xaSFVaRTUr?=
 =?utf-8?B?Ni9wU3RrVkhpR1QyYXN0NGt1NjZtNWxQc21VdHdkeWgzaUdUT3Y4K0d6SGl1?=
 =?utf-8?B?aEZTTFhEbHpuOFNzYXRBZzhYL1ZKeDZBbmNpZnZQdUpNRVFoclA5UXZickFF?=
 =?utf-8?B?TGxNVWFXVHl5amlnVU1YdXdUb3hwMGNlVnV0TzEzKzdTQ0pGYkFRQ0FMS1hh?=
 =?utf-8?B?Vmw1eVVzZXduY1Y1VmFrQVM0c2VSOXNCV3FqQ0w0dWEwVGFlakVxRCt2U2xR?=
 =?utf-8?B?U09leDkwcVFVQk9uK2VoNTRhMGlqaWpaR2pSWWVzUWxqS2oxWmpneSs1cnZE?=
 =?utf-8?B?RDdHbHMxUWVkcTNkZTZUdnNFRGx0NjZKbE5BS1VVVlNZeG5CY09KREtpZ3NH?=
 =?utf-8?B?YlFCMW5aSDRicTZ5aFpIL090L3ZOdkNhTndPNU9GMml0TDNTdUxTbGNpSWYv?=
 =?utf-8?B?OEp0M0V3T1l0ZlVkTmtpejFaZW8rZXdIL29RbnFCVU9BejE4UnRtTHJOMGhh?=
 =?utf-8?B?M1ZEU1ZLcDRMNEFaYWJTVGd5amxORllyNXNsRVF4amFRKzRLVXVMSk5xQXhq?=
 =?utf-8?B?TnJsb2xVRDJZaEx3cmFsRUhld1p3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a30a6c3d-c8fc-4575-d77b-08d9ea0c3ac9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 07:34:09.7855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulFovrt7fV1Jl/kDdTf5dD1gu7OyzpXOc35kqMgPzx+KvHkQ5JwLBpeXIsptAzCrMLWpO5Y93phYFt0nLV5VA08cfbBIZjqk2kG6WYcb9SU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4661
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10250 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=2 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202070048
X-Proofpoint-GUID: OOYYFN2zCHTLxSZtY-XDFL5TMOVBJAc3
X-Proofpoint-ORIG-GUID: OOYYFN2zCHTLxSZtY-XDFL5TMOVBJAc3
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 05:30:15PM -0600, Gustavo A. R. Silva wrote:
> There is a regular need in the kernel to provide a way to declare having
> a dynamically sized set of trailing elements in a structure. Kernel code
> should always use “flexible array members”[1] for these cases. The older
> style of one-element or zero-length arrays should no longer be used[2].
> 
> This helps with the ongoing efforts to globally enable -Warray-bounds
> and get us closer to being able to tighten the FORTIFY_SOURCE routines
> on memcpy().
> 
> This issue was found with the help of Coccinelle and audited and fixed,
> manually.

How are you auditing this manually?  I have to re-audit it manually
myself as a reviewer and I'm find it tricky.

>  /*-- IBSS Parameter Set ---------------------------*/
> @@ -288,7 +288,7 @@ struct wlan_ie_ibss_parms {
>  struct wlan_ie_challenge {
>  	u8 eid;
>  	u8 len;
> -	u8 challenge[1];
> +	u8 challenge[];
>  } __packed;

This is dead code.  It would have been better to just delete that.  I
have a lot of experience at reviewing "Delete Dead Code" patches.

regards,
dan carpenter


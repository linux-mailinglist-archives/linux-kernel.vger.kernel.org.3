Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774D6576A23
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 00:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiGOWqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 18:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiGOWqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 18:46:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB641F8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:46:33 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FKYdhB028381;
        Fri, 15 Jul 2022 22:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=R2/Ukckc9NLFoCkWqNrRlhAENzBM4TEuPqsn1MYbUTU=;
 b=Rh21lEZVlb2YVQneyYEPHmBdb0nDeYdKxCT0O3C2boWkWXpN/bqgEV2SXVHmza6ex6oo
 9oHIKAVoKvSfu91JlnML3SxxS6a8bQ1JJtQYekLKYzGkrBzBvV9qQvi7saDTWXYSWCWp
 HgYXTZTYwwiq87zXZL+n4O3PV0mIjAKMkrCleiE81SxR5b60RYjQFpYdeH8c4pIQe9JU
 k2x1CPCIRy8GnAp9Eq8ZwinfICvGDXBNF/RmTn9ebPQsUAtyTb3MGkTzMk3z0l56BsOj
 rPGOWdHjG4nOpHj2XNfPykhYEMCMN0pf27vpQT0D9VnXuoR88wy38xiNC8W11+xLzWYR Xw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71r1gjuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 22:46:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26FMZi9b027780;
        Fri, 15 Jul 2022 22:46:21 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7047u31p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 22:46:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaErgS8BtIrQiNCR9RUiGmgqyy+rrPRPoxgnSbPGgxWLvoWVfWU8Xo/k1bU+42n2K7FMX9kLj4j7a9+FGltbcr4UNpNbT1iU8lKKu5o9ECxCloBS+rkSv5DUGVyRVc1YgcoGV1+u2IUAad9azvkS+BRvKVWqLjKXIWz3bY5vGfauSuQHrFneOJML6rXe/VvmBjn62lqcnRgJCX8BGAzz15bwacZ5lN6OWvh9Wrlkl7eab2uUIIBQ4zj+jnrXFOUSWa2eb7QgP9yLi3ZeC6qPoUwrK5XxABCTbhp1BSBACf8w8hN42LvU40IKtvnDMNNc20MlLptRHNcpI/Pn2ACvXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2/Ukckc9NLFoCkWqNrRlhAENzBM4TEuPqsn1MYbUTU=;
 b=j5zWDlA0rpx6gkbZdbhLE6Xb8v1FBLgBLbs5qxV/IyJes55wZdQ23wpIF2v0QiicSYLykcaX2UmfI5vjSS2vRibx8l7ijPf/pR6mE5lqHud99NVZhzyFrzIDxPWn0D7NLrIxsnPpwMzYmVzzsL/PeE8gKW21/PKxc/9ytSbPK9kJIRFLVQdgHoFbxPTBbHH1506nVzSwVBknLO23+a73ydS1/xob3cO+ldVzmlo7RSOrV/Q8rh933iu6vwQrN7EwfR50XyM11rhz8R0T7tev+lgw8Ur7heogvB0PiWdrZvfx7Qn3K5fBpiZ4PW2owqTLmihL4eYitLsjvJjjRFLtOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2/Ukckc9NLFoCkWqNrRlhAENzBM4TEuPqsn1MYbUTU=;
 b=LvjqxKOrjIxFS+2qPjXajYy2toOGYP5oKWqbOHfCwqljJHOHjJFB45mMSlHTpZ10nIZ4rH3WmwSPcOui/ITNNW+HDzURcQwIJawsSThMSMvK85VgrlC8/Vt8NruBhtlvIk8/su/RIF9KhcOffmgeB+5/wlSo8NwdgePz6aFvPo8=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CY4PR10MB1750.namprd10.prod.outlook.com (2603:10b6:910:9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Fri, 15 Jul
 2022 22:46:18 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2ce3:447b:f3ee:bf1e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2ce3:447b:f3ee:bf1e%5]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 22:46:18 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] acpi/nfit: badrange report spill over to clean range
Thread-Topic: [PATCH] acpi/nfit: badrange report spill over to clean range
Thread-Index: AQHYlX3HVbDs2AmFoUigIZUcRQZQvK17eX+AgAGCqQCAAAjvAIABgQiAgAAgsgCAAQ46gIAAHxMAgAA6SYA=
Date:   Fri, 15 Jul 2022 22:46:18 +0000
Message-ID: <7ed50fd8-521e-cade-77b1-738b8bfb8502@oracle.com>
References: <20220711232658.536064-1-jane.chu@oracle.com>
 <62ce16518e7d3_6070c29447@dwillia2-xfh.jf.intel.com.notmuch>
 <09df842d-d8e4-0594-56b0-b4bb9ea37b67@oracle.com>
 <62cf622a32e1_16b52e294ea@dwillia2-xfh.jf.intel.com.notmuch>
 <8b13446a-65ac-0cbd-6c17-0f9e1cfbb048@oracle.com>
 <62d0c0947c3e6_1643dc2944a@dwillia2-xfh.jf.intel.com.notmuch>
 <82641e64-1003-d11a-df9c-73f3b61d6b8a@oracle.com>
 <62d1bd546fce2_242d29499@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <62d1bd546fce2_242d29499@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3dea90f7-7c9c-436c-18f1-08da66b3d4ea
x-ms-traffictypediagnostic: CY4PR10MB1750:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mErDwcICKGyyrLH9it3zT6Tkx+R+9KYXLmhZlo7Xx4AwSfCgj1dxI/vIERFEA7mH/8TLHzQrQzI82okQr4rNDWR/HOLy/ivXXDuv317qWuWsx0IegO/ZAuDXaOHkkwdVQRBNhzHxRFTiWpFx/LDVo9d8yFePHTvECS2YFATnJ2vb5W96iMD9XwjXoRaFAUhhMgPqDYJa3WT7VsKJ1VbEg8kBMdaAveKg48af5sXkLAabExSoUASUGPnl85EtsvMELdTtXD2EENH/Imr+UH+xn4dWBcyqOyjGkQgCAmrQxo80jTe+RXqXklPpJe+uL+LDQUucr0qwFK6MQ3wSW48NZLw/pAdb71W+AHm6i0swiSHppqmqwQ23Pe44f0hSfAOhC0MzB7Lnz8AEFcxUiuopsbKoae01orCggPkToGBxXqFJq1md38s4aMwgj8MwWoz+Xmgde6MO7wgSbGPF/lhLl9HkkfVxUAsYcAy/SNnUQK4aaRshqMdfIMxTVeHLENcAwihhdk2bRjM49tGOYaNbNY7LQ7q6/2r4umhYqPM4KazjvGNnbLElWPMjlUxn5dC0EAOsWV8KE76ps50dLwaurJgWYKLgYhOKc1AKQ+FtPRKZcuKTxR0x55SyNbqIQWRCnU1tHty4HELlXngprCLgxhCxsJMpjk1KJlDoGfByUMODABy90BHoXzKqsDiKpdqLh6HqR224Ge0azQoSZFmUb4I5qi7aC9RxVFqAoYnYGwi2ZyNzXFLFjn0+NeNJ/lk1izAltBD0xz9+YR1L+CfM9fujANCFycuJLDL/2WnT+QdWKsZjHsNnBSZqXakGgYJHZ7HjwxSfWv9PnDsH7FKXlepFpxRdlnEEQKaB+xYOTnR+TKTtY/TjFy7gXW2NXR+C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(346002)(136003)(39860400002)(366004)(8936002)(6506007)(122000001)(31686004)(41300700001)(316002)(38100700002)(36756003)(5660300002)(44832011)(76116006)(66476007)(2616005)(8676002)(186003)(53546011)(478600001)(6512007)(31696002)(86362001)(26005)(2906002)(110136005)(38070700005)(64756008)(6486002)(66556008)(66946007)(66446008)(91956017)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUU3endXR0VPYnE0RktueTZncUxyT3k3MlltWFpNR3VZbG1YbGVLV2x2NE9X?=
 =?utf-8?B?aTFWZENoWUNoMEYrMi9WQ3YwMVEzRHN5UVJTSis5QjUzdTN2VnNXRzk2RUhj?=
 =?utf-8?B?a2d2UGJyeEFrcmNpdVRFTTEyQ0tnd3lWdTJzanhXS2FvdEM0anhlblZjQnlE?=
 =?utf-8?B?T3krTDRuMmpjcTgwMEFBTDJUSTNKdUpZZVpVa0JFSHZja2M1Y2ZuYkFueTdq?=
 =?utf-8?B?cExvUklWV0dPaklGQTZUK0ZPcGN2aG9WK1QvUEpUN04yVTJ1MGhqTlg1cnhK?=
 =?utf-8?B?OW05MjQ3ZzIyMnlPZlFkNlRUMnc2ZWpzc2orUFFxT1Q4NjVFci9kcHJNQ2ln?=
 =?utf-8?B?eXRQOWp5MmMyeTNtS0NvcUx0K3pBLy9ZMUJ5emIvazV4aFlIc2lzRTRNWm9r?=
 =?utf-8?B?eHZnMFd5Zkc2VG9QVWo2eEZKY3VpYkpJNVJ1bnM4Nzl5V0RpaHBNelozK3Nw?=
 =?utf-8?B?YWY4WjRSeHNUaGkrZW5kdHpEVyt0Z3lLZGJNVVRHUFE5ZndXMENuR0RXT3Nq?=
 =?utf-8?B?Yzh4ckRHREVjMERJN09RczNLaVh4SFlhSW9BbXBtejlWRFZERTg3VUZDL2I2?=
 =?utf-8?B?NWE4UFREOE45cXdPUzRNWkVsbUpsODFYU0RvS0p5aUgwVTQrS3g0Um4wdHNH?=
 =?utf-8?B?NlFLcU5sMDhEajI5Y1RkSU9kdE1TQnl1cllWNTlzS1pQUnQ3ZzNwOG13d0J5?=
 =?utf-8?B?T0hDc3R0Y3NUOG9VUjJxYldGdGlyRmd4UFY3Z0gzNHNyMlFMWnBCYy9tU2FS?=
 =?utf-8?B?clJJMDF0THVrS05iRmZnK0xscy9VWTQ5MGVaUUdDTUlSSnREdHBoN2pVS04v?=
 =?utf-8?B?YXJUR1BIcHR3MTIxempRbmlpZFFncmdOb2NtUFdnMzlqMUVoanVsOEhBR284?=
 =?utf-8?B?TUpjME1EV3BCN2ZKQWtDZk9UUnQzSW04bFJZczBNNXFXa2dYbnA1dmNjU1V1?=
 =?utf-8?B?c202bzdkNmp3azlFY2xlQzQvNG5QY2dNa2JqWnRUNHRPQUI1WUNic1dTNS9N?=
 =?utf-8?B?bXBEczZXa0dDRTB2WjRDT2tvR2FKdHRjNkVxZjFuWFUybE9VMng4VXk0dm5T?=
 =?utf-8?B?aFA3Z2FhR2hXZTNjNldNWWlWNFNsdXZVNmZYRXZzNFYvcmFTbzhUak9MZE1U?=
 =?utf-8?B?U0pqa2dhTDJnaUU0ZkF3aThKZXZ6SU4zd3Q5UEIyNUt5WktuUUF5RnNjNklG?=
 =?utf-8?B?bkdJZDNzR2ExWWxMQ0Y4UjRIeWl1bmxIWUt0a1BSVlpUTG5DMkZYRGNEVzBx?=
 =?utf-8?B?cVE1WGkzcmUrd0RVaUw1OG93SUxVREFXbHdBM3lwUGZrSmpFczB5Ri9Jb1hU?=
 =?utf-8?B?R2E3QS9HTXRGNFRUYW5CYk9BQ3ZCbmFld3owVHg3dTltYUFPSC9ydXlycGxs?=
 =?utf-8?B?WVlENXdFSUFtMkNqSEp3QkYwdmR5ajZDb0xVRHFCdHVEMDJOQmhDV0pBWEJ2?=
 =?utf-8?B?QkZDY1MyQVRtUXVWQTFwU09nVUFPcGh1cnIyUVgxNHpLNFR4TCtxUWljYnFY?=
 =?utf-8?B?bk81WHNJQmJCaG45dzlPTWxXZ1NJNWhvRkNuNForUWdvZnQ4TUd0RDZTRDZ1?=
 =?utf-8?B?Z1o1OFpPNXlrMGJMUlBNRWkrUjJna0ZuOTZNeDN4UUp4cVFHWExLRFBtR0xr?=
 =?utf-8?B?bDNzWVloSVI5cUhaWi81cVBtQ21jaFB3SmVHVFJFeVkvbllJc3hnTVNOdWRT?=
 =?utf-8?B?QXRuT3VoY2tFUExzekc5Rm1nWlpZdG5HRFQwNnVaczlTcHN3dlFnUnp6NjVn?=
 =?utf-8?B?d3RJMit3dGd1V3NTTnNLMC9velN1V0Z0cy9DekphTVkvYkNaMGI5UlhldHFK?=
 =?utf-8?B?L2tQVHpnc1AxWmZFTlBLYVFLZlNhemFzcjI0V3BwdWZoOTZRV09uMENOeEFa?=
 =?utf-8?B?MSt3OU5sd2UzdDBTZzhXUmRqUFFRUjExSTNJZmozSXVDUFVWQkRYTkFkNis4?=
 =?utf-8?B?R3o4aGFaNXZRWS8wYktzQ09Rd0pyUjdNMWQwRVhLMDNJQlljcHFFVGg3VHhR?=
 =?utf-8?B?a2FPZ1Z5TXJTRUJabUlYMThRMyt4cHR4WlBBNXcwejVjbjZkYkVoeG02SFFa?=
 =?utf-8?B?a2JjRklrSVhJQ2lvMGJoTFg4c1RDR0IwNDJIcUVoK0ZnemQzNWlhMUJYSjVa?=
 =?utf-8?Q?mR00=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EB36271F2DBB44692BA9CF36258D4DD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dea90f7-7c9c-436c-18f1-08da66b3d4ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 22:46:18.3324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eYFPM5n46A7fMmbk/5FE3hSQt3bmhTgtqkrJR+0uKHkrEME4nN14NJu3TfyxNa9SjH0rkX73xTkDzbZ6stw8TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1750
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-15_13:2022-07-14,2022-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207150100
X-Proofpoint-ORIG-GUID: GfMBQNOHF7txOFbOwOopnoBlNGu-Bmbq
X-Proofpoint-GUID: GfMBQNOHF7txOFbOwOopnoBlNGu-Bmbq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xNS8yMDIyIDEyOjE3IFBNLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+IFsgYWRkIFRvbnkg
XQ0KPiANCj4gSmFuZSBDaHUgd3JvdGU6DQo+PiBPbiA3LzE0LzIwMjIgNjoxOSBQTSwgRGFuIFdp
bGxpYW1zIHdyb3RlOg0KPj4+IEphbmUgQ2h1IHdyb3RlOg0KPj4+PiBJIG1lYW50IHRvIHNheSB0
aGVyZSB3b3VsZCBiZSA4IGNhbGxzIHRvIHRoZSBuZml0X2hhbmRsZV9tY2UoKSBjYWxsYmFjaywN
Cj4+Pj4gb25lIGNhbGwgZm9yIGVhY2ggcG9pc29uIHdpdGggYWNjdXJhdGUgYWRkcmVzcy4NCj4+
Pj4NCj4+Pj4gQWxzbywgc2hvcnQgQVJTIHdvdWxkIGZpbmQgMiBwb2lzb25zLg0KPj4+Pg0KPj4+
PiBJIGF0dGFjaGVkIHRoZSBjb25zb2xlIG91dHB1dCwgbXkgYW5ub3RhdGlvbiBpcyBwcmVmaXhl
ZCB3aXRoICI8PT0iLg0KPj4+DQo+Pj4gWzI5MDc4LjYzNDgxN10gezR9W0hhcmR3YXJlIEVycm9y
XTogICBwaHlzaWNhbF9hZGRyZXNzOiAweDAwMDAwMDQwYTA2MDI2MDAJCTw9PSAybmQgcG9pc29u
IEAgMHg2MDANCj4+PiBbMjkwNzguNjQyMjAwXSB7NH1bSGFyZHdhcmUgRXJyb3JdOiAgIHBoeXNp
Y2FsX2FkZHJlc3NfbWFzazogMHhmZmZmZmZmZmZmZmZmZjAwDQo+Pj4NCj4+PiBXaHkgaXMgbmZp
dF9oYW5kbGVfbWNlKCkgc2VlaW5nIGEgNEsgYWRkcmVzcyBtYXNrIHdoZW4gdGhlIENQRVIgcmVj
b3JkDQo+Pj4gaXMgc2VlaW5nIGEgMjU2LWJ5dGUgYWRkcmVzcyBtYXNrPw0KPj4NCj4+IEdvb2Qg
cXVlc3Rpb24hICBPbmUgd291bGQgdGhpbmsgYm90aCBHSEVTIHJlcG9ydGluZyBhbmQNCj4+IG5m
aXRfaGFuZGxlX21jZSgpIGFyZSBjb25zdW1pbmcgdGhlIHNhbWUgbWNlIHJlY29yZC4uLg0KPj4g
V2hvIG1pZ2h0IGtub3c/DQo+IA0KPiBEaWQgc29tZSBncmVwcGluZy4uLg0KPiANCj4gSGF2ZSBh
IGxvb2sgYXQ6IGFwZWlfbWNlX3JlcG9ydF9tZW1fZXJyb3IoKQ0KPiANCj4gIlRoZSBjYWxsIGlz
IGNvbWluZyBmcm9tIGluc2lkZSB0aGUgaG91c2UhIg0KPiANCj4gTHVja2lseSB3ZSBkbyBub3Qg
bmVlZCB0byBjb250YWN0IGEgQklPUyBlbmdpbmVlciB0byBnZXQgdGhpcyBmaXhlZC4NCg0KR3Jl
YXQsIHRoYW5rIHlvdSENCkp1c3QgcHV0IHRvZ2V0aGVyIGEgcXVpY2sgZml4IGZvciByZXZpZXcg
YWZ0ZXIgSSB0ZXN0ZWQgaXQuDQoNCj4gDQo+Pj4gU2lnaCwgaXMgdGhpcyAiZmlybXdhcmUtZmly
c3QiIGNhdXNpbmcgdGhlIGtlcm5lbCB0byBnZXQgYmFkIGluZm9ybWF0aW9uDQo+Pj4gdmlhIHRo
ZSBuYXRpdmUgbWVjaGFuaXNtcyA+DQo+Pj4gSSB3b3VsZCBleHBlY3QgdGhhdCBpZiB0aGlzIHRl
c3Qgd2FzIHRydWx5IHdvcnJpZWQgYWJvdXQgbWluaW1pemluZyBCSU9TDQo+Pj4gbGF0ZW5jeSBp
dCB3b3VsZCBkaXNhYmxlIGZpcm13YXJlLWZpcnN0IGVycm9yIHJlcG9ydGluZy4gSSB3b25kZXIg
aWYNCj4+PiB0aGF0IGZpeGVzIHRoZSBvYnNlcnZlZCBwcm9ibGVtPw0KPj4NCj4+IENvdWxkIHlv
dSBlbGFib3JhdGUgb24gZmlybXdhcmUtZmlyc3QgZXJyb3IgcGxlYXNlPyAgV2hhdCBhcmUgdGhl
DQo+PiBwb3NzaWJsZSBjb25zZXF1ZW5jZXMgZGlzYWJsaW5nIGl0PyBhbmQgaG93IHRvIGRpc2Fi
bGUgaXQ/DQo+IA0KPiBXaXRoIG15IExpbnV4IGtlcm5lbCBkZXZlbG9wZXIgaGF0IG9uLCBmaXJt
d2FyZS1maXJzdCBlcnJvciBoYW5kbGluZyBpcw0KPiByZWFsbHkgb25seSB1c2VmdWwgZm9yIHN1
cHBvcnRpbmcgbGVnYWN5IG9wZXJhdGluZyBzeXN0ZW1zIHRoYXQgZG8gbm90DQo+IGhhdmUgbmF0
aXZlIG1hY2hpbmUgY2hlY2sgaGFuZGxpbmcsIG9yIGZvciBwbGF0Zm9ybXMgdGhhdCBoYXZlIGJ1
Z3MgdGhhdA0KPiB3b3VsZCBvdGhlcndpc2UgY2F1c2UgT1MgbmF0aXZlIGVycm9yIGhhbmRsaW5n
IHRvIGZhaWwuIE90aGVyd2lzZSwgZm9yDQo+IG1vZGVybiBMaW51eCwgZmlybXdhcmUtZmlyc3Qg
ZXJyb3IgaGFuZGxpbmcgaXMgcHVyZSBvdmVyaGVhZCBhbmQgYQ0KPiBzb3VyY2Ugb2YgYnVncy4N
Cj4gDQo+IEluIHRoaXMgY2FzZSB0aGUgYnVnIGlzIGluIHRoZSBMaW51eCBjb2RlIHRoYXQgdHJh
bnNsYXRlcyB0aGUgQUNQSSBldmVudA0KPiBiYWNrIGludG8gYW4gTUNFIHJlY29yZC4NCg0KVGhh
bmtzIQ0KDQotamFuZQ0KDQo=

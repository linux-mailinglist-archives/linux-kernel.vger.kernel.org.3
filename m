Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82118572A09
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 01:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbiGLXd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 19:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiGLXdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 19:33:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D06B8511
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 16:33:23 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CLDx53003008;
        Tue, 12 Jul 2022 23:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2d7LsKdvI+fmgxaXFnUrNfUal+Sabeeaf8CRRBUKy7Q=;
 b=PbA32Ya/sE5ZjOKqOd2z0iwiPbu7X8SWgM9dFtSR9x2vtKgHHKjzg6+DZ3FlrdqA8qVD
 SOuhBYD8BYnum8CqxGYLWQXeqmGCEOYY2QRDX5/HruNzldO7dDp1Zd0a1ZzdQr4llaPl
 Ufemrp+1frDibDjAJLBZvTNwZAFTiN91HADqFpxdqux83RXI2CrK6ItY6t15LGKbjLuM
 ZJWm1SwOeAPaGIAqNQhzvexRKYbGwBxFGX2ctkBfMA5MT/YYY4Zqbm3ZIL2I44WiXvCt
 KtXWzFxXcvqm7lZOPlPsLXPD/8UDuBAYuaWK7nnMirUt4+S+xQFq8qZlc0QzJNrc74Is 3Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71r18a8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 23:33:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CNAq43036327;
        Tue, 12 Jul 2022 23:33:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7043yp8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 23:33:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Svu59CQ1EjEpgubk+CBBJG/eJW2hjluT+eBnNSjO3FlHVFEYr+uok6Sff9OzrGp0Mk6THdMpeBjzIGsWw6Sta605O7mUp1r0d95XmSa18mgRkMN5u9SEZXkLS/5g/We5pmdpbyrZbWhFJfzNpin5i//zhsPgaz7BWvFdv46X0HGkdSAIhJ35VbCl9yl15jpXOAPV8znJ4eGTQ1GmB8npkB9yTSArlIXIhVLmlZjwa14EufrizsuUstkp0mo1iXx3vq0QVvM8tct2JUHPfLhYRxdKxLnc8swDWUQUbBXeZGN5xX+czQVhVtj1XUnuIcC2SW3tx+caO/OGdEUCRo2/vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2d7LsKdvI+fmgxaXFnUrNfUal+Sabeeaf8CRRBUKy7Q=;
 b=CsVt0BjTSaOz16eIcUwLlpfSJP293XaD+bWGVJWQ7Cxv514H2KBgyYGSPDyGikrOYDNzhZAoZgtT/+QRZFenEno8YtHCVHqOYzZs1CFkMPLG2iP5SLg81SVSTa1TT/yvAMVi2tiBxoiqgkSerSqM8fzOEyn8QxCNanFa+vwpVsdJ5YERRGDzljyzjJLLRVJLT/uQ7+xUMOjlqfs128JG2WgGmYk5QPqHKHWRINlQ4wzHiAbi/+eVY4wXecaxIiM2SwcbNVT3tUMhIR1gQamoiuGtD587oiNhb91twPP6Xq9StUd7E+HsEb7EY6vXNrxO4Qf3cA3f1NQGKDEtSL+w2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2d7LsKdvI+fmgxaXFnUrNfUal+Sabeeaf8CRRBUKy7Q=;
 b=WGszfkJVh7nzW3CzXdWcOkoEs9X8pRqZsaSvj6i4TFt3/1siyvQTeDNNhpTh3nzLZUvyxMOIW5jQ+kJU+Epra7ClXPgldwUtgSfHfKcjFL1QOx5Uiia/yTSS4HaoNoyEYEsNVNlw6Gogy4y3jWGPGHzhHXUd+4VMAtMlfUGYzes=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CH2PR10MB3910.namprd10.prod.outlook.com (2603:10b6:610:11::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 23:33:02 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2ce3:447b:f3ee:bf1e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2ce3:447b:f3ee:bf1e%4]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 23:33:02 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     kernel test robot <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: drivers/nvdimm/pmem.c:48:20: error: conflicting types for
 'to_phys'; have 'phys_addr_t(struct pmem_device *, phys_addr_t)' {aka 'long
 long unsigned int(struct pmem_device *, long long unsigned int)'}
Thread-Topic: drivers/nvdimm/pmem.c:48:20: error: conflicting types for
 'to_phys'; have 'phys_addr_t(struct pmem_device *, phys_addr_t)' {aka 'long
 long unsigned int(struct pmem_device *, long long unsigned int)'}
Thread-Index: AQHYiD+o7Ha67nltK0OdU4Ow6wg7Sq17fvSA
Date:   Tue, 12 Jul 2022 23:33:02 +0000
Message-ID: <4a3f9fb7-d39d-684a-610a-cece69b74bb0@oracle.com>
References: <202206250257.AhQLLkHA-lkp@intel.com>
In-Reply-To: <202206250257.AhQLLkHA-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76161336-b800-49d4-159d-08da645edcea
x-ms-traffictypediagnostic: CH2PR10MB3910:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?YTlBeVZJb2l4Vkg4THA2SmlqT3h4YndtTU1OYytpMHlGUVFjUklPQ0pnKzVk?=
 =?utf-8?B?c3ZXM0lsTXgwWndFak1VKzRvamMvZncxSUtYeS9lN2FDaGZWWkxxVXNwVW5B?=
 =?utf-8?B?d3lsTnViRlNNajFMMC9UK2dNekx3TjU2bUV2RWo3ODhWc3AyZHVpVGJzWCtv?=
 =?utf-8?B?ckRmZW1yNVJhSzFpVHB4cUJpQlVPMzg2MVhaZUpjU3ZkMnNWYVZyOGZVTW5u?=
 =?utf-8?B?ZGh3Y1pFOUJaYjk0L2ZFRGJHeEJ0QUlvOUM5aWhEcTV2ZEpwWlhMMm03Vlg3?=
 =?utf-8?B?Z0psd0c3cGZOLzQvMXB6b0lERi83ZDVYUkJacFN2S1FEY2Vaa0pZWFdkK2xC?=
 =?utf-8?B?QVVORkw2YlVKS0dXUllWVEZta0hNT0pGZzIwZkN3STdxb2hJeFd5SHErdmtG?=
 =?utf-8?B?Tjg5SWRzRDMyNlQ2QzV3czRRbUhpdmk3Y3d1N3U4RjkyVEl3a1V3b0FEMGxC?=
 =?utf-8?B?dVZ2a0FFOGRzWGQ1OXFEUnZzSWhuckdPSStxQ3VzMGcrSm5aTkpFS0hzNWRs?=
 =?utf-8?B?N2FWVmE1dFpHaEhVU1RlWEdncWt6QVRJNFMvNHRNcEZJT2txazlYakE3ZUp0?=
 =?utf-8?B?MzlVS0RWcndub3hIa1l3ODRNemo1d0ZoOXdsSDZaVG9nUnVVOU9PckpReGFQ?=
 =?utf-8?B?MGt1VVAvaTd3V0s3Z1JXaXdSd25nbjh4dWp4ak52SlUzczJITVF6cnVRRW9M?=
 =?utf-8?B?QlhMbUdIeFJWaUpkdnRTeFovM3RtSXQyRTl4ZUZyQndLdjJJRHBsYUJYY1Zo?=
 =?utf-8?B?VW11WEVZZVVmdTZXbkxqaWhndkZ0cFZveEtBdWhLcmtZQ29iTm5JeSs5dXVT?=
 =?utf-8?B?dkxiTnppaXZmeXlOL1FqZWp2QnlTSTJBSjEyczIydFFXZG9uOXNHNU53d05s?=
 =?utf-8?B?cUV5MnhBVHVtYWNrYitDZHlZQjd4VFZocXJ0dDh4UkpUZDNNdUUwTXdrUFRq?=
 =?utf-8?B?VkFTSzZVZHhhZGZQOUVMd2dtU2hMUXd2dWZRNkRVWVgrbStsc2VIR2pHRDVw?=
 =?utf-8?B?ZkpEcjExS3cwS3E5d3Z5NFJmKzhJTFNDVURJNTgwQnJZazBDdG1IRXNoV2F1?=
 =?utf-8?B?OUhhM3hUSXlwRjc2V0x4a29kNUJwL0NBV2l5aG5nL3EzZ0V0SFk2RlRrdGZu?=
 =?utf-8?B?T3BTaWp4dE5kNk4vdWF2STV0OUdrcklDbmNZRDJFV1RNcTE4clhkS2N4MnpK?=
 =?utf-8?B?bnJQYnRuZXhWYXptMkVEQUxjTWRyK2E0bjFpTU1STjA0MmMyekZTVzNubDIw?=
 =?utf-8?B?Wi9sY3U2SmFRQlg1VTlBRC9oUHBxbjR3cDlmL0xuWnhNRGxNUHFQOU5Nd09W?=
 =?utf-8?Q?XZTXxNcdnE4tc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(366004)(39860400002)(346002)(136003)(31696002)(2906002)(44832011)(54906003)(5660300002)(31686004)(38070700005)(86362001)(6916009)(36756003)(122000001)(316002)(478600001)(8676002)(38100700002)(66446008)(6506007)(66476007)(4326008)(66556008)(64756008)(66946007)(26005)(41300700001)(83380400001)(6512007)(6486002)(966005)(71200400001)(53546011)(186003)(2616005)(76116006)(91956017)(8936002)(223183001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVJTTm0xaFBENDIyb1p4Y3FOZE5hNzI3WDhtS3VDWWp2MDU3Yk9wL3lyNi9B?=
 =?utf-8?B?Rnc0NFkwSFJXMEh5WEU0OUJzbDI1NFJESVl0Yjkxcnh2YWU3YXFoSWNlRUFt?=
 =?utf-8?B?NHhYbk9mRlVmNXVrVkkrckxiNTVEankrd0pLMndxb3Irbk01a243SldnSVc3?=
 =?utf-8?B?SSs2QmQ3c0orYThNak1mbUIvN3B2V1gvUWYyNmIva3JHbXhsSkFYQkJLTVFL?=
 =?utf-8?B?RnJXTUJjRldmYjMyUlYyeWxkNzczaUIwcWVRVDRqOW1OVEJYVHBLcjE0U0VZ?=
 =?utf-8?B?YVNhN3ppMnd6dFloYnYwQUlTbE1xTWxPQ2Q3dkN1cDlCaHdITnVnUnZTaU1B?=
 =?utf-8?B?TlZXa2dUZE1YeEM5MnM5bW9Pa0hJdlhUTUdwMm1BYlBPcnZYdzlFNlpTbUZz?=
 =?utf-8?B?eUdjR012NWtlRFJzakh3SUI1cEVydlNiYzYxeGMvWktSNUdWaFkyeXVEWFVB?=
 =?utf-8?B?cW1BTXRrNE9UTU5lK3ZuYmdId2JlQUJ5OE5JbCs3aVo2a3Y4ejJodkRKZUZB?=
 =?utf-8?B?bStvZ1MwTlV6U0QwWHY4MFAxWTluczhCd1J4dTVTNGJRQmkxbDRtYXUwUFhh?=
 =?utf-8?B?ZUN5NGxpYWliL2RBSmlRdFgvOUwyZmtCMUV4Qm1WYlJBSEJIK3RaaENpNzdv?=
 =?utf-8?B?UHltSHJXc1NqK3M5NytnU2dYZzV1NGZ2anZSZ1JDUDdXdDM4UmpMbFV5bnd5?=
 =?utf-8?B?MkwzcmhmNFpsU20wUUdhNGg4bDkvSlFGZzU4eS85VGdhZER6TW15bTR0aDJF?=
 =?utf-8?B?MzJHME1FbDFwRXVqUmNvcGMrWHBUVUtTQk5Bdi8zK2tOaVBYU2JpU1pGZU5q?=
 =?utf-8?B?T2szWHpFcEk0RnJ1UHJ1eVA2bjFzYzlxemdLQmcrZmhRM1RhdUN4V1FVTWJh?=
 =?utf-8?B?RW9kdzh0bmZuYmJmZUszaHdIcVd3dFg3RUhrN1EvbjZMYXN2a05FcVlqVDZj?=
 =?utf-8?B?RVZDYVlObzVOOEFsRzRET1dQSXNZSHJiTkNXVzc4T0lYQWdRektoaDdUYnhE?=
 =?utf-8?B?SzF2NVlRT0ZKK0wyWFIvZGw0ZVZVUG11aUdONzVuOG9LS2tZeDJQSEV1ZUw5?=
 =?utf-8?B?QVIzVjdJeVU0YkdENVUxMHFUK0x5dHRsMnV6d3Z2RTQvbnN2Zk94cDlSRTkr?=
 =?utf-8?B?TGZRU3NNTTZuOUVYdm83M2J5eEFlNEFvUmJKNi9nSzd0aUFMNmZMcUcreE5o?=
 =?utf-8?B?dnFpR29abnJHWFMxejBLVHUrRm1ZaXh0aXI3M0VyWjJ3cHFHcnk2dXZDVUgr?=
 =?utf-8?B?eGRmb1dmd2pLamUvQVpvWkV0VWNkNTVMc2VmM1dmV3dYYVJuaEtMZkdSVzlT?=
 =?utf-8?B?eVJFMDRCeHdCa09ITFJZNkpWVE1RSVVReUx2QlcyMzVLSW9RSXdXN08vN28x?=
 =?utf-8?B?cUVqUHpLQWVyOEpSZXp3TG1LenJibzJkdXJGY1RrT1pOMHpQMzFkK29qbW9R?=
 =?utf-8?B?VDVEUUttbTBZOGJiSWphTVliVFhpZjNhci9EeVMzUStuaUpQczNBaVpXQ3Zk?=
 =?utf-8?B?VFZvTVBucjFMc2NXU01aNGVuSzBGREZpbVpHVEFWVVdoeXRkakVuTE90Y1Y0?=
 =?utf-8?B?UFZIZkxCblgvZ3pWSlVRWWYzZkpNejdDMkpHMjVxYWx1RVlVbDFkQ3Q4bVdr?=
 =?utf-8?B?anBwYUlmOVZ4cVdsQXdrK1I5NmNPYitpY0gyWjlTazVveTlRZkRYV2EwaWNC?=
 =?utf-8?B?dWFmR0NrTVVVaWhsbiswMVpBMjhIZFBXSlJMa2gwaFNadGR6cDNON0pIL0JI?=
 =?utf-8?B?aGd2c3RZaktiYnQ4Tkl4WUZHZ0x4T2VVcDBpWm02Y3BjSVVjY0hkQ0dMTHBv?=
 =?utf-8?B?eU1pUk5zV1BldDREZDAwU3Y1NnNiQ3dtTmlMVWZEV1drcUgyTSsvbVgzNURX?=
 =?utf-8?B?Sy9NcXI4NkNwZHFDNHE4M2ZZRjFuSUNhYzdiL0lOTDFrajFqbDJ2Wkl5K21J?=
 =?utf-8?B?RXFRTUJCSWpab0JyRTE5S2FKNDlSMVhlRk4zQjU4cnZUTDFTTGVuMHg1OXRn?=
 =?utf-8?B?UkNyZzU2OE0yV1o5VmpOdWVRbTVXd3dDeDVVOUhsbU1JTnpwL3B1aWpqdXFI?=
 =?utf-8?B?VXJEQmc0eWRmLzNBdWt3Y3dnVlk0SU5iVFFHdnZJMG5mQk9VbnJoSkM4eGFY?=
 =?utf-8?Q?ghOQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A09481ADA41835449BC448641958BB0F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76161336-b800-49d4-159d-08da645edcea
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 23:33:02.2066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oD9TV3jkC6KW/JkEIVrmUqSUR2iRyVxZ+MIK2AXy/ANcmBcM32KwEL6vv18In0lF4M5t1t52C32UUpR3EJxn4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3910
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_12:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207120095
X-Proofpoint-ORIG-GUID: ekrtRXz6Q2hnoKpocCW7hb8xglhLmkJX
X-Proofpoint-GUID: ekrtRXz6Q2hnoKpocCW7hb8xglhLmkJX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QXBvbG9neSBmb3IgZGVsYXllZCByZXBseSwgdGhpcyBpc3N1ZSBoYXMgYmVlbiBmaXhlZC4NCg0K
LWphbmUNCg0KT24gNi8yNC8yMDIyIDc6NTggUE0sIGtlcm5lbCB0ZXN0IHJvYm90IHdyb3RlOg0K
PiBIaSBKYW5lLA0KPiANCj4gRllJLCB0aGUgZXJyb3Ivd2FybmluZyBzdGlsbCByZW1haW5zLg0K
PiANCj4gdHJlZTogICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC90b3J2YWxkcy9saW51eC5naXQgbWFzdGVyDQo+IGhlYWQ6ICAgOTJmMjBmZjcyMDY2ZDhk
N2UyZmZiNjU1YzIyMzYyNTlhYzlkMWM1ZA0KPiBjb21taXQ6IDk0MDljOWI2NzA5ZTU5ODY2ZWQz
NTQwYjVkN2Y1MjkxNDM5ZTQ4MzMgcG1lbTogcmVmYWN0b3IgcG1lbV9jbGVhcl9wb2lzb24oKQ0K
PiBkYXRlOiAgIDYgd2Vla3MgYWdvDQo+IGNvbmZpZzogdW0tYWxsbW9kY29uZmlnDQo+IGNvbXBp
bGVyOiBnY2MtMTEgKERlYmlhbiAxMS4zLjAtMykgMTEuMy4wDQo+IHJlcHJvZHVjZSAodGhpcyBp
cyBhIFc9MSBidWlsZCk6DQo+ICAgICAgICAgICMgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9OTQwOWM5
YjY3MDllNTk4NjZlZDM1NDBiNWQ3ZjUyOTE0MzllNDgzMw0KPiAgICAgICAgICBnaXQgcmVtb3Rl
IGFkZCBsaW51cyBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC90b3J2YWxkcy9saW51eC5naXQNCj4gICAgICAgICAgZ2l0IGZldGNoIC0tbm8tdGFncyBsaW51
cyBtYXN0ZXINCj4gICAgICAgICAgZ2l0IGNoZWNrb3V0IDk0MDljOWI2NzA5ZTU5ODY2ZWQzNTQw
YjVkN2Y1MjkxNDM5ZTQ4MzMNCj4gICAgICAgICAgIyBzYXZlIHRoZSBjb25maWcgZmlsZQ0KPiAg
ICAgICAgICBta2RpciBidWlsZF9kaXIgJiYgY3AgY29uZmlnIGJ1aWxkX2Rpci8uY29uZmlnDQo+
ICAgICAgICAgIG1ha2UgVz0xIE89YnVpbGRfZGlyIEFSQ0g9dW0gU0hFTEw9L2Jpbi9iYXNoDQo+
IA0KPiBJZiB5b3UgZml4IHRoZSBpc3N1ZSwga2luZGx5IGFkZCBmb2xsb3dpbmcgdGFnIHdoZXJl
IGFwcGxpY2FibGUNCj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwu
Y29tPg0KPiANCj4gQWxsIGVycm9ycyAobmV3IG9uZXMgcHJlZml4ZWQgYnkgPj4pOg0KPiANCj4+
PiBkcml2ZXJzL252ZGltbS9wbWVtLmM6NDg6MjA6IGVycm9yOiBjb25mbGljdGluZyB0eXBlcyBm
b3IgJ3RvX3BoeXMnOyBoYXZlICdwaHlzX2FkZHJfdChzdHJ1Y3QgcG1lbV9kZXZpY2UgKiwgcGh5
c19hZGRyX3QpJyB7YWthICdsb25nIGxvbmcgdW5zaWduZWQgaW50KHN0cnVjdCBwbWVtX2Rldmlj
ZSAqLCBsb25nIGxvbmcgdW5zaWduZWQgaW50KSd9DQo+ICAgICAgICA0OCB8IHN0YXRpYyBwaHlz
X2FkZHJfdCB0b19waHlzKHN0cnVjdCBwbWVtX2RldmljZSAqcG1lbSwgcGh5c19hZGRyX3Qgb2Zm
c2V0KQ0KPiAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgXn5+fn5+fg0KPiAgICAgSW4g
ZmlsZSBpbmNsdWRlZCBmcm9tIGFyY2gvdW0vaW5jbHVkZS9hc20vcGFnZS5oOjk4LA0KPiAgICAg
ICAgICAgICAgICAgICAgICBmcm9tIGFyY2gvdW0vaW5jbHVkZS9hc20vdGhyZWFkX2luZm8uaDox
NSwNCj4gICAgICAgICAgICAgICAgICAgICAgZnJvbSBpbmNsdWRlL2xpbnV4L3RocmVhZF9pbmZv
Lmg6NjAsDQo+ICAgICAgICAgICAgICAgICAgICAgIGZyb20gaW5jbHVkZS9hc20tZ2VuZXJpYy9w
cmVlbXB0Lmg6NSwNCj4gICAgICAgICAgICAgICAgICAgICAgZnJvbSAuL2FyY2gvdW0vaW5jbHVk
ZS9nZW5lcmF0ZWQvYXNtL3ByZWVtcHQuaDoxLA0KPiAgICAgICAgICAgICAgICAgICAgICBmcm9t
IGluY2x1ZGUvbGludXgvcHJlZW1wdC5oOjc4LA0KPiAgICAgICAgICAgICAgICAgICAgICBmcm9t
IGluY2x1ZGUvbGludXgvc3BpbmxvY2suaDo1NSwNCj4gICAgICAgICAgICAgICAgICAgICAgZnJv
bSBpbmNsdWRlL2xpbnV4L3dhaXQuaDo5LA0KPiAgICAgICAgICAgICAgICAgICAgICBmcm9tIGlu
Y2x1ZGUvbGludXgvd2FpdF9iaXQuaDo4LA0KPiAgICAgICAgICAgICAgICAgICAgICBmcm9tIGlu
Y2x1ZGUvbGludXgvZnMuaDo2LA0KPiAgICAgICAgICAgICAgICAgICAgICBmcm9tIGluY2x1ZGUv
bGludXgvaGlnaG1lbS5oOjUsDQo+ICAgICAgICAgICAgICAgICAgICAgIGZyb20gaW5jbHVkZS9s
aW51eC9idmVjLmg6MTAsDQo+ICAgICAgICAgICAgICAgICAgICAgIGZyb20gaW5jbHVkZS9saW51
eC9ibGtfdHlwZXMuaDoxMCwNCj4gICAgICAgICAgICAgICAgICAgICAgZnJvbSBpbmNsdWRlL2xp
bnV4L2Jsa2Rldi5oOjksDQo+ICAgICAgICAgICAgICAgICAgICAgIGZyb20gZHJpdmVycy9udmRp
bW0vcG1lbS5jOjEwOg0KPiAgICAgYXJjaC91bS9pbmNsdWRlL3NoYXJlZC9tZW0uaDoxMjoyOTog
bm90ZTogcHJldmlvdXMgZGVmaW5pdGlvbiBvZiAndG9fcGh5cycgd2l0aCB0eXBlICdsb25nIHVu
c2lnbmVkIGludCh2b2lkICopJw0KPiAgICAgICAgMTIgfCBzdGF0aWMgaW5saW5lIHVuc2lnbmVk
IGxvbmcgdG9fcGh5cyh2b2lkICp2aXJ0KQ0KPiAgICAgICAgICAgfCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXn5+fn5+fg0KPiAgICAgSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGFyY2gvdW0v
aW5jbHVkZS9hc20vcGFnZS5oOjExNCwNCj4gICAgICAgICAgICAgICAgICAgICAgZnJvbSBhcmNo
L3VtL2luY2x1ZGUvYXNtL3RocmVhZF9pbmZvLmg6MTUsDQo+ICAgICAgICAgICAgICAgICAgICAg
IGZyb20gaW5jbHVkZS9saW51eC90aHJlYWRfaW5mby5oOjYwLA0KPiAgICAgICAgICAgICAgICAg
ICAgICBmcm9tIGluY2x1ZGUvYXNtLWdlbmVyaWMvcHJlZW1wdC5oOjUsDQo+ICAgICAgICAgICAg
ICAgICAgICAgIGZyb20gLi9hcmNoL3VtL2luY2x1ZGUvZ2VuZXJhdGVkL2FzbS9wcmVlbXB0Lmg6
MSwNCj4gICAgICAgICAgICAgICAgICAgICAgZnJvbSBpbmNsdWRlL2xpbnV4L3ByZWVtcHQuaDo3
OCwNCj4gICAgICAgICAgICAgICAgICAgICAgZnJvbSBpbmNsdWRlL2xpbnV4L3NwaW5sb2NrLmg6
NTUsDQo+ICAgICAgICAgICAgICAgICAgICAgIGZyb20gaW5jbHVkZS9saW51eC93YWl0Lmg6OSwN
Cj4gICAgICAgICAgICAgICAgICAgICAgZnJvbSBpbmNsdWRlL2xpbnV4L3dhaXRfYml0Lmg6OCwN
Cj4gICAgICAgICAgICAgICAgICAgICAgZnJvbSBpbmNsdWRlL2xpbnV4L2ZzLmg6NiwNCj4gICAg
ICAgICAgICAgICAgICAgICAgZnJvbSBpbmNsdWRlL2xpbnV4L2hpZ2htZW0uaDo1LA0KPiAgICAg
ICAgICAgICAgICAgICAgICBmcm9tIGluY2x1ZGUvbGludXgvYnZlYy5oOjEwLA0KPiAgICAgICAg
ICAgICAgICAgICAgICBmcm9tIGluY2x1ZGUvbGludXgvYmxrX3R5cGVzLmg6MTAsDQo+ICAgICAg
ICAgICAgICAgICAgICAgIGZyb20gaW5jbHVkZS9saW51eC9ibGtkZXYuaDo5LA0KPiAgICAgICAg
ICAgICAgICAgICAgICBmcm9tIGRyaXZlcnMvbnZkaW1tL3BtZW0uYzoxMDoNCj4gICAgIGRyaXZl
cnMvbnZkaW1tL3BtZW0uYzogSW4gZnVuY3Rpb24gJ3BtZW1fZGF4X3plcm9fcGFnZV9yYW5nZSc6
DQo+Pj4gYXJjaC91bS9pbmNsdWRlL2FzbS9wYWdlLmg6MTA1OjIwOiBlcnJvcjogdG9vIGZldyBh
cmd1bWVudHMgdG8gZnVuY3Rpb24gJ3RvX3BoeXMnDQo+ICAgICAgIDEwNSB8ICNkZWZpbmUgX19w
YSh2aXJ0KSB0b19waHlzKCh2b2lkICopICh1bnNpZ25lZCBsb25nKSAodmlydCkpDQo+ICAgICAg
ICAgICB8ICAgICAgICAgICAgICAgICAgICBefn5+fn5+DQo+ICAgICBpbmNsdWRlL2FzbS1nZW5l
cmljL21lbW9yeV9tb2RlbC5oOjE4OjQ2OiBub3RlOiBpbiBkZWZpbml0aW9uIG9mIG1hY3JvICdf
X3Bmbl90b19wYWdlJw0KPiAgICAgICAgMTggfCAjZGVmaW5lIF9fcGZuX3RvX3BhZ2UocGZuKSAg
ICAgIChtZW1fbWFwICsgKChwZm4pIC0gQVJDSF9QRk5fT0ZGU0VUKSkNCj4gICAgICAgICAgIHwg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+DQo+ICAgICBh
cmNoL3VtL2luY2x1ZGUvYXNtL3BndGFibGUuaDoyNzY6NDA6IG5vdGU6IGluIGV4cGFuc2lvbiBv
ZiBtYWNybyAncGh5c190b19wZm4nDQo+ICAgICAgIDI3NiB8ICNkZWZpbmUgcGh5c190b19wYWdl
KHBoeXMpIHBmbl90b19wYWdlKHBoeXNfdG9fcGZuKHBoeXMpKQ0KPiAgICAgICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fg0KPiAgICAgYXJj
aC91bS9pbmNsdWRlL2FzbS9wZ3RhYmxlLmg6Mjc3OjMwOiBub3RlOiBpbiBleHBhbnNpb24gb2Yg
bWFjcm8gJ3BoeXNfdG9fcGFnZScNCj4gICAgICAgMjc3IHwgI2RlZmluZSBfX3ZpcnRfdG9fcGFn
ZSh2aXJ0KSBwaHlzX3RvX3BhZ2UoX19wYSh2aXJ0KSkNCj4gICAgICAgICAgIHwgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn4NCj4gICAgIGFyY2gvdW0vaW5jbHVkZS9h
c20vcGd0YWJsZS5oOjI3Nzo0Mzogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvICdfX3BhJw0K
PiAgICAgICAyNzcgfCAjZGVmaW5lIF9fdmlydF90b19wYWdlKHZpcnQpIHBoeXNfdG9fcGFnZShf
X3BhKHZpcnQpKQ0KPiAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBefn5+DQo+ICAgICBhcmNoL3VtL2luY2x1ZGUvYXNtL3BndGFibGUuaDoyNzk6
Mjg6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyAnX192aXJ0X3RvX3BhZ2UnDQo+ICAgICAg
IDI3OSB8ICNkZWZpbmUgdmlydF90b19wYWdlKGFkZHIpIF9fdmlydF90b19wYWdlKChjb25zdCB1
bnNpZ25lZCBsb25nKSBhZGRyKQ0KPiAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBefn5+fn5+fn5+fn5+fg0KPiAgICAgYXJjaC91bS9pbmNsdWRlL2FzbS9wZ3RhYmxlLmg6
OTM6MjY6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyAndmlydF90b19wYWdlJw0KPiAgICAg
ICAgOTMgfCAjZGVmaW5lIFpFUk9fUEFHRSh2YWRkcikgdmlydF90b19wYWdlKGVtcHR5X3plcm9f
cGFnZSkNCj4gICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+
fg0KPiAgICAgZHJpdmVycy9udmRpbW0vcG1lbS5jOjI5OTo1Njogbm90ZTogaW4gZXhwYW5zaW9u
IG9mIG1hY3JvICdaRVJPX1BBR0UnDQo+ICAgICAgIDI5OSB8ICAgICAgICAgcmV0dXJuIGJsa19z
dGF0dXNfdG9fZXJybm8ocG1lbV9kb193cml0ZShwbWVtLCBaRVJPX1BBR0UoMCksIDAsDQo+ICAg
ICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBefn5+fn5+fn4NCj4gICAgIGRyaXZlcnMvbnZkaW1tL3BtZW0uYzo0ODoyMDogbm90
ZTogZGVjbGFyZWQgaGVyZQ0KPiAgICAgICAgNDggfCBzdGF0aWMgcGh5c19hZGRyX3QgdG9fcGh5
cyhzdHJ1Y3QgcG1lbV9kZXZpY2UgKnBtZW0sIHBoeXNfYWRkcl90IG9mZnNldCkNCj4gICAgICAg
ICAgIHwgICAgICAgICAgICAgICAgICAgIF5+fn5+fn4NCj4gICAgIGRyaXZlcnMvbnZkaW1tL3Bt
ZW0uYzozMDI6MTogZXJyb3I6IGNvbnRyb2wgcmVhY2hlcyBlbmQgb2Ygbm9uLXZvaWQgZnVuY3Rp
b24gWy1XZXJyb3I9cmV0dXJuLXR5cGVdDQo+ICAgICAgIDMwMiB8IH0NCj4gICAgICAgICAgIHwg
Xg0KPiAgICAgY2MxOiBzb21lIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzDQo+IA0K
PiANCj4gdmltICs0OCBkcml2ZXJzL252ZGltbS9wbWVtLmMNCj4gDQo+ICAgICAgNDcJDQo+ICAg
ID4gNDgJc3RhdGljIHBoeXNfYWRkcl90IHRvX3BoeXMoc3RydWN0IHBtZW1fZGV2aWNlICpwbWVt
LCBwaHlzX2FkZHJfdCBvZmZzZXQpDQo+ICAgICAgNDkJew0KPiAgICAgIDUwCQlyZXR1cm4gcG1l
bS0+cGh5c19hZGRyICsgb2Zmc2V0Ow0KPiAgICAgIDUxCX0NCj4gICAgICA1MgkNCj4gDQoNCg==

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F5357403A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 01:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiGMXwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 19:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiGMXwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 19:52:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1343B52DE7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 16:52:30 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DNjXnl019277;
        Wed, 13 Jul 2022 23:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Z7lLcptb/IeWoP31/xOGH53PdZBk800rC9MNpZuAQdo=;
 b=uuzdLF/W1gVopedndhSaqiVz5KGwXLWf+RWD/1QMJIspRfiONmhiMKHoRSo7xZh+cf3+
 zRJIzY/XMGSWH0xo6Q1ruG8PLzYD5j1WDVc5N51TPmhH/K9s4qIF9rCKP2QRxXD/XiSP
 JjuaM2NvyWypAEdbmBhySO25nMPc+uJOgTZertXMlH82mxUgkPtbigaA0bVcLkQArTiV
 XZMx5uEJKFbhMe5pAnjvkDOsjGCjlCso2StHjMjQ5IqQjdBT5Hx1W4FC/1fNDA6Nti1e
 d2UaN09k+Ji9DKwdUyxZnvwl/31rRP2hSvANV4cDng9uhh4AK57phdSdOA4/yoibmCek Iw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrknav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 23:52:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26DNorEQ028600;
        Wed, 13 Jul 2022 23:52:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7044ws6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 23:52:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+WRIRHKcMvaFHefFgdSv/tHjT1oGVw2KIA3s2fqx69ezKzTsn06VapkJBMk4ovS+HF4Iru9GFUnzvGEDChTnet+NSMRZm4XxG2EDA4nKvptFOiTU/k3JhTgewtOZgTYg/Ze8KHHn9dnwBkVvMcyQROzRsO/IF7iTCbTxwEfIqf39UdqusH+QW7hjTKeFFL2S86oYrpN0hHRkgYJ8iKUtSaBUAUqIzYnBRotR6yYcaWUmktqO4G73kDt5Y2DL6aFhscV6zznL8KByzGMtvFpGDWAwso7Lx3jmclhUgMQHdXkyxHaLKSNdhxzPfL/pbLJBlci9liYT5n2TWYKTYFi1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7lLcptb/IeWoP31/xOGH53PdZBk800rC9MNpZuAQdo=;
 b=U0gNYBlg23PZHOBHGP6uzccFVnyUCJ6ACWFu+L2WrNbGp5APvad6VbxNcD6XUfX1LC+N849sNc9lLV+49z/qCbSAHCmZBXxNdSUR3qRs2Qw4es8hW161f56LeQnFx1VLJRBhpGFSGg/F8lsH5mZQJ8Q3z6oKizbufv90iSDIulDzzwqUYKo5oi79ZweuCDYCFDOQ628OU4IGTstPwLDU/ABrecC4d4TkNXK+Xxqe5dtooX1F/NXuOWSajglTrRD5ubWjzQ373Ax5kXBLiLxsTGHwMXgsuYsODgllhsMs3sIubCqBNgBxGX56/szgSlEVrOyewZ5rbpUCpcCpuJzV8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7lLcptb/IeWoP31/xOGH53PdZBk800rC9MNpZuAQdo=;
 b=wn50lvEVnxMcjyMUkr8Kp36RMrN+w13FyykW6FcBhfOOmXN8Py8IFE5T1is9j/UyB8jB++LKyOODRBHTZ7Te9jkJgpWCHEubdDigfLA1y80gJOxC4DqKNGUOPJdcLOGQmPmZm1LRDCnqU0Lvs0VnpGG/ASEt565+IyOP5IZUJD4=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by PH0PR10MB5657.namprd10.prod.outlook.com (2603:10b6:510:fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 23:52:13 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2ce3:447b:f3ee:bf1e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2ce3:447b:f3ee:bf1e%4]) with mapi id 15.20.5417.028; Wed, 13 Jul 2022
 23:52:13 +0000
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
Thread-Index: AQHYlX3HVbDs2AmFoUigIZUcRQZQvK17eX+AgAGCqQA=
Date:   Wed, 13 Jul 2022 23:52:13 +0000
Message-ID: <09df842d-d8e4-0594-56b0-b4bb9ea37b67@oracle.com>
References: <20220711232658.536064-1-jane.chu@oracle.com>
 <62ce16518e7d3_6070c29447@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <62ce16518e7d3_6070c29447@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5ed1f40-0f50-4ced-8f54-08da652ab547
x-ms-traffictypediagnostic: PH0PR10MB5657:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yZ6htCcwyco/uOG6sc72kxlLr4E4FsldtoniefDMvTM4PxGdzZg4VrWCyW7lQQeQ5Rw6AoKrqgYu4tkLf2QfauaQNunQiW/+7IU87AF0b/CMqh7A0hjGI04uYQ/XPhW0i4QkoeeRhdsx7RoEKrUIWgNOpsnXhgcqohJVJ9UL2F9WnSv0OLzN7dlkYBssh8t+mndYbtcMFEVOtsbir/K0KIPEPsSu+ATl+ejDqNIXyE68B4d3CEmbAHx6dZbSeDY3+vAt1X0WVoUrcTbAfO95DflXCEn97hLVaiXYhYFgnKA806Slw9ah3GCXoRugPIojF/ClTI5HB1psRI6z7RZaNlb61+ehIUXLEYu8eCTAApZcltO5VELoHl8qg3GCzMK7xDMDyigqNnkesnDNNAOiD17ZUKSh/IegbcYxzqv3xQcdtzbK6M3oWX5qZEP3BRTcLyn5ZNHXcrYbUQzHm3trmgCyXEcEVkxJ3u3oifzZycp/4s8gmMUM8rCoQqGiNFsvkDqTR+AXYJ5YR31flkyJL3pOcZ5/3cMEaiiOxhDkuqf/2pQzC8FMD2MufOHaaoJowRkKnX/zHRRXQK+G8Y45utIQa8xbaWLjyskaPPBbFmO+0j/sZUREqo+fQ5uySDeC2j0nybJs3Scuz+gVr6TErBhcIwsW9EidyKc+idBjlsU/5dGAcun4whi5mc9WSI/T8r7RiAr++OVsOkfGRh8L4C5oztIDYTdJkcwSyhFFHlapurNTxSEi1ZKeIhISBE/WhjRYggE0yRF6HIjsfvq1cJeTUcPmtGlKId1cjJZBHG98euoiJBsaT581sOwS6k8o+jI8nj150G3ZZB4nLJPCqwZ5QgXOKNeBWC1aOItQqguDgD0hAUV7Z1ggKnBlCD+MtkIhjzKTnVsCyJgc34ThXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(366004)(136003)(346002)(2616005)(186003)(6512007)(38070700005)(478600001)(2906002)(8676002)(64756008)(316002)(44832011)(41300700001)(53546011)(66476007)(66946007)(66556008)(66446008)(76116006)(6506007)(71200400001)(86362001)(8936002)(91956017)(83380400001)(5660300002)(31686004)(122000001)(26005)(31696002)(36756003)(6486002)(38100700002)(110136005)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFB5MUNXWW9EemFVTGQ4LytvRzdQZ3d6YnkvWDJpU09qZkFOQjgrOEMyYTdp?=
 =?utf-8?B?bCtsdElQNTh5K1ZyeU9RSTdFcEZHTTZpSzhGNHRpa25yVEpuU2Y5YTA2SjE1?=
 =?utf-8?B?aHEwcktvZU1nck4xTVdWSnlINDlBYTdnYUQxa242YmNsZlBtM3JadGZVb2FH?=
 =?utf-8?B?eGNZT1BUWmN3UkdFRVh0OFRycW5BQmRDQ25HZHhiTzd6RWIwdGt0Slp3eXl1?=
 =?utf-8?B?MlJEK3pOSFBEdG9FSFRPU1p5cmlWUStBR3YxNEdONVNDalk4aHVpRFRzNDA4?=
 =?utf-8?B?aXpHdHFDd0NtYVF4U0tmR2JLQ2UzQWJKUjNOMkdydElwak9TdE5vU24rQ001?=
 =?utf-8?B?NC9MNnJpNDNwYUx1eGhuQmNSdlF6c0I1eFhYUmhBSlRZQ1dPeHNHYnZOL2Ju?=
 =?utf-8?B?L1NNa2VVTlRuNHZCdUwzWEpRaXllOFA1UU16NjJ6NE9UTFExM0hGZWJzSFA0?=
 =?utf-8?B?QlExY21ManhaZ25hNmlWcEx1OFpHQW1ONUpzcFJXTmpnRWJVeGo1clV0UDhy?=
 =?utf-8?B?Z1ViMFloZ1FkbSs1R2RaYm80OXNzRU1vcjRCM1pUa0lua0s5WlZFc0hFRVhm?=
 =?utf-8?B?MHVIT3lKejZVOERjczdNQytYd1FGNnJRQXBQYmZHaktPSUtUaGVnZXZ2ek95?=
 =?utf-8?B?SnZmT0FLQnNWbU5RS2JuMGlCK1Q4UUp0V2NLcXByaWNGRHFFZWdZZnpKNkx2?=
 =?utf-8?B?NStZSW5Fc055Nng3dHYrajNNaS9YTE5MejBIU2tOYkpmbk9RRElSaXZaZGxY?=
 =?utf-8?B?MGh5NXozVm4zM0VNaHpOc0lyUGRoSE1RenVpQ3RqTUxVei9Nb3hzTnpqY1o2?=
 =?utf-8?B?dDJHNUZIaGpCYXZzZU5INHN6LzZDVmNZbzIyMDFuVE56anMxanpVZEk1Z2dH?=
 =?utf-8?B?MmpZL2xyZHYwMGVlSEJ0dDU5Nk1QU1VPYXBBTHJtdlN2a093ZHdROTFPWFU5?=
 =?utf-8?B?Q0t6VWpmZWJUMkc3ZEtzd0x6RU10NHdjSkhUaFpnbDFkcjRhRWpkK3JFQWJw?=
 =?utf-8?B?WnZaa0M5UXN1SUpwSkQ4VEtTbGNvc3JFcVBPcG5hSStCRFlHa05XelFMTnh0?=
 =?utf-8?B?Vng5eld6U1NHR2ZCU2VYalFPMllPYmwza3loVVFZNmt2K0Nqdmd3a0JoR2Jp?=
 =?utf-8?B?amFEeGNkMWRQQXZleERXZlV3bG1aajVYY0h5dTRXd3hMbG9iQ2VpV2JQMmJ6?=
 =?utf-8?B?c2w2N0pmMVVRdXVBb3BlWVBoRWVvWHV3RTJYY05GZHZITTEyQXJwTWlZdmt0?=
 =?utf-8?B?N21xbnJwNXhoaVA3WlAzcjNLUHdVRWVnclhFbVdpRG5rZDdxNlo0REZ2T1Ro?=
 =?utf-8?B?TFlQaitqMWpDYkUzVVU1bFJLVnN5Z1NsZ1JtR2hzMjNNRFUwTGc0R2NacE0y?=
 =?utf-8?B?WjJ4MmJFUVN1V1QvWmszaVlha3BhRHVRNklkR0lPczBJcjlMdmdXM3V3b0dE?=
 =?utf-8?B?cG9mY3A2VTJIRkVqaSs3T1NTbzdJSjU4b3FZVXVyQ0xFN3BMMS9xZjEwNENx?=
 =?utf-8?B?djVRL254VFBRUFJuR0FCa2VoNVJOemE1V3E5dzA4NXRWN2wwbFpMcDN4eGJP?=
 =?utf-8?B?bWZqaFlnOUk4UnNlNWhEZndzZUNNWE8xTm12MEgvbExHZ0UwVGZ1cmpycENx?=
 =?utf-8?B?R1E1TDlPOTVEemhoSDhJWHZ4R2xFOW1GdnZmV2lEc0VPM2tlL2ttVEF2elY5?=
 =?utf-8?B?MmMvKzNZajQxbzg5bVNUMlpmdTN5dWl2Q2RCclBYVk8yWjdPelRUUmVRSU5B?=
 =?utf-8?B?TGpKdlc2QVVYQXB5SVVCMTY4L2VZbUF4QnpPSVRtd1owckhYbWVXUm5PRzFm?=
 =?utf-8?B?NHh5K1ZZcGc4WDZ2cmRFc3BnTCtPRmM1Y0ZoYWV2NGE0aWZHRlcvTXFFNFlL?=
 =?utf-8?B?R1hCSUtMa2FJUHdxVG85cC9DTVo4ZUFTSWNvaDR4dnYxcGxiVzBjenA4c3g1?=
 =?utf-8?B?RmYzU09YMWdMSXBGSWJ4V2U4K2pWVGVITjVrQlJ1UkYvdklOYkszV283eExn?=
 =?utf-8?B?c2lxakYyNXhXa3F6T1EwSy9JNEZrSkloMUZRTHlDcDNVbEQxb3V4RXpPTjRT?=
 =?utf-8?B?V1IzQy9LeWZkWS9iNjNmbmRiMk14SU0xalpCallWYmdMWC94cUVraHBYOHlF?=
 =?utf-8?Q?G3Rk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E400ACE463D3A8499B90C0B153377B72@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ed1f40-0f50-4ced-8f54-08da652ab547
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 23:52:13.0275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e/0199JNcbAVQs9Y6lbDPSPAaodTyKBoF1a70PmGqKeYCYkxVqkCG9qfOJUP+UMKOOfI0lWbM3oU0DbxmR0C7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5657
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-13_13:2022-07-13,2022-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207130095
X-Proofpoint-GUID: yC0mu8Ky8-ho9pAUAF_ew9ytJVTf26c6
X-Proofpoint-ORIG-GUID: yC0mu8Ky8-ho9pAUAF_ew9ytJVTf26c6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xMi8yMDIyIDU6NDggUE0sIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gSmFuZSBDaHUgd3Jv
dGU6DQo+PiBDb21taXQgNzkxN2Y5Y2RiNTAzICgiYWNwaS9uZml0OiByZWx5IG9uIG1jZS0+bWlz
YyB0byBkZXRlcm1pbmUgcG9pc29uDQo+PiBncmFudWxhcml0eSIpIGNoYW5nZWQgbmZpdF9oYW5k
bGVfbWNlKCkgY2FsbGJhY2sgdG8gcmVwb3J0IGJhZHJhbmdlIGZvcg0KPj4gZWFjaCBwb2lzb24g
YXQgYW4gYWxpZ25tZW50IGluZGljYXRlZCBieSAxVUxMIDw8IE1DSV9NSVNDX0FERFJfTFNCKG1j
ZS0+bWlzYykNCj4+IGluc3RlYWQgb2YgdGhlIGhhcmRjb2RlZCBMMV9DQUNIRV9CWVRFUy4gSG93
ZXZlciByZWNlbnRseSBvbiBhIHNlcnZlcg0KPj4gcG9wdWxhdGVkIHdpdGggSW50ZWwgRENQTUVN
IHYyIGRpbW1zLCBpdCBhcHBlYXJzIHRoYXQNCj4+IDFVTCA8PCBNQ0lfTUlTQ19BRERSX0xTQiht
Y2UtPm1pc2MpIHR1cm5zIG91dCBpcyA0S2lCLCBvciA4IDUxMi1ieXRlIGJsb2Nrcy4NCj4+IENv
bnNlcXVlbnRseSwgaW5qZWN0aW5nIDIgYmFjay10by1iYWNrIHBvaXNvbnMgdmlhIG5kY3RsLCBh
bmQgaXQgcmVwb3J0cw0KPj4gOCBwb2lzb25zLg0KPj4NCj4+IFsyOTA3Ni41OTAyODFdIHszfVtI
YXJkd2FyZSBFcnJvcl06ICAgcGh5c2ljYWxfYWRkcmVzczogMHgwMDAwMDA0MGEwNjAyNDAwDQo+
PiBbLi5dDQo+PiBbMjkwNzYuNjE5NDQ3XSBNZW1vcnkgZmFpbHVyZTogMHg0MGEwNjAyOiByZWNv
dmVyeSBhY3Rpb24gZm9yIGRheCBwYWdlOiBSZWNvdmVyZWQNCj4+IFsyOTA3Ni42Mjc1MTldIG1j
ZTogW0hhcmR3YXJlIEVycm9yXTogTWFjaGluZSBjaGVjayBldmVudHMgbG9nZ2VkDQo+PiBbMjkw
NzYuNjM0MDMzXSBuZml0IEFDUEkwMDEyOjAwOiBhZGRyIGluIFNQQSAxICgweDQwODAwMDAwMDAs
IDB4MWY4MDAwMDAwMCkNCj4+IFsyOTA3Ni42NDg4MDVdIG5kX2J1cyBuZGJ1czA6IFhYWCBudmRp
bW1fYnVzX2FkZF9iYWRyYW5nZTogKDB4NDBhMDYwMjAwMCwgMHgxMDAwKQ0KPj4gWy4uXQ0KPj4g
WzI5MDc4LjYzNDgxN10gezR9W0hhcmR3YXJlIEVycm9yXTogICBwaHlzaWNhbF9hZGRyZXNzOiAw
eDAwMDAwMDQwYTA2MDI2MDANCj4+IFsuLl0NCj4+IFsyOTA3OS41OTUzMjddIG5maXQgQUNQSTAw
MTI6MDA6IGFkZHIgaW4gU1BBIDEgKDB4NDA4MDAwMDAwMCwgMHgxZjgwMDAwMDAwKQ0KPj4gWzI5
MDc5LjYxMDEwNl0gbmRfYnVzIG5kYnVzMDogWFhYIG52ZGltbV9idXNfYWRkX2JhZHJhbmdlOiAo
MHg0MGEwNjAyMDAwLCAweDEwMDApDQo+PiBbLi5dDQo+PiB7DQo+PiAgICAiZGV2IjoibmFtZXNw
YWNlMC4wIiwNCj4+ICAgICJtb2RlIjoiZnNkYXgiLA0KPj4gICAgIm1hcCI6ImRldiIsDQo+PiAg
ICAic2l6ZSI6MzM4MjA3NzAzMDQsDQo+PiAgICAidXVpZCI6ImExYjBmMDdmLTc0N2YtNDBhOC1i
Y2Q0LWRlMTU2MGExZWY3NSIsDQo+PiAgICAic2VjdG9yX3NpemUiOjUxMiwNCj4+ICAgICJhbGln
biI6MjA5NzE1MiwNCj4+ICAgICJibG9ja2RldiI6InBtZW0wIiwNCj4+ICAgICJiYWRibG9ja19j
b3VudCI6OCwNCj4+ICAgICJiYWRibG9ja3MiOlsNCj4+ICAgICAgew0KPj4gICAgICAgICJvZmZz
ZXQiOjgyMDgsDQo+PiAgICAgICAgImxlbmd0aCI6OCwNCj4+ICAgICAgICAiZGltbXMiOlsNCj4+
ICAgICAgICAgICJubWVtMCINCj4+ICAgICAgICBdDQo+PiAgICAgIH0NCj4+ICAgIF0NCj4+IH0N
Cj4+DQo+PiBTbywgMVVMIDw8IE1DSV9NSVNDX0FERFJfTFNCKG1jZS0+bWlzYykgaXMgYW4gdW5y
ZWxpYWJsZSBpbmRpY2F0b3IgZm9yIHBvaXNvbg0KPj4gcmFkaXVzIGFuZCBzaG91bGRuJ3QgYmUg
dXNlZC4gIE1vcmUgb3ZlciwgYXMgZWFjaCBpbmplY3RlZCBwb2lzb24gaXMgYmVpbmcNCj4+IHJl
cG9ydGVkIGluZGVwZW5kZW50bHksIGFueSBhbGlnbm1lbnQgdW5kZXIgNTEyLWJ5dGUgYXBwZWFy
IHdvcmtzOg0KPj4gTDFfQ0FDSEVfQllURVMgKHRob3VnaCBpbmFjY3VyYXRlKSwgb3IgMjU2LWJ5
dGVzIChhcyBhcnMtPmxlbmd0aCByZXBvcnRzKSwNCj4+IG9yIDUxMi1ieXRlLg0KPj4NCj4+IFRv
IGdldCBhcm91bmQgdGhpcyBpc3N1ZSwgNTEyLWJ5dGVzIGlzIGNob3NlbiBhcyB0aGUgYWxpZ25t
ZW50IGJlY2F1c2UNCj4+ICAgIGEuIGl0IGhhcHBlbnMgdG8gYmUgdGhlIGJhZGJsb2NrIGdyYW51
bGFyaXR5LA0KPj4gICAgYi4gbmRjdGwgaW5qZWN0LWVycm9yIGNhbm5vdCBpbmplY3QgbW9yZSB0
aGFuIG9uZSBwb2lzb24gdG8gYSA1MTItYnl0ZSBibG9jaywNCj4+ICAgIGMuIGFyY2hpdGVjdHVy
ZSBhZ25vc3RpYw0KPiANCj4gSSBhbSBmYWlsaW5nIHRvIHNlZSB0aGUga2VybmVsIGJ1Zz8gWWVz
LCB5b3UgaW5qZWN0ZWQgbGVzcyB0aGFuIDgNCj4gImJhZGJsb2NrcyIgb2YgcG9pc29uIGFuZCB0
aGUgaGFyZHdhcmUgcmVwb3J0ZWQgOCBibG9ja3Mgb2YgcG9pc29uLCBidXQNCj4gdGhhdCdzIG5v
dCB0aGUga2VybmVsJ3MgZmF1bHQsIHRoYXQncyB0aGUgaGFyZHdhcmUuIFdoYXQgaGFwcGVucyB3
aGVuDQo+IGhhcmR3YXJlIHJlYWxseSBkb2VzIGRldGVjdCA4IGJsb2NrcyBvZiBjb25zZWN0aXZl
IHBvaXNvbiBhbmQgdGhpcw0KPiBpbXBsZW1lbnRhdGlvbiBkZWNpZGVzIHRvIG9ubHkgcmVjb3Jk
IDEgYXQgYSB0aW1lPw0KDQpJbiB0aGF0IGNhc2UsIHRoZXJlIHdpbGwgYmUgOCByZXBvcnRzIG9m
IHRoZSBwb2lzb25zIGJ5IEFQRUkgR0hFUywgYW5kDQpBUkMgc2NhbiB3aWxsIGFsc28gcmVwb3J0
IDggcG9pc29ucywgZWFjaCB3aWxsIGdldCB0byBiZSBhZGRlZCB0byB0aGUgDQpiYWQgcmFuZ2Ug
dmlhIG52ZGltbV9idXNfYWRkX2JhZHJhbmdlKCksIHNvIG5vbmUgb2YgdGhlbSB3aWxsIGJlIG1p
c3NlZC4NCg0KSW4gdGhlIGFib3ZlIDIgcG9pc29uIGV4YW1wbGUsIHRoZSBwb2lzb24gaW4gMHgw
MDAwMDA0MGEwNjAyNDAwIGFuZCBpbiANCjB4MDAwMDAwNDBhMDYwMjYwMCB3ZXJlIHNlcGFyYXRl
bHkgcmVwb3J0ZWQuDQoNCj4gDQo+IEl0IHNlZW1zIHRoZSBmaXggeW91IHdhbnQgaXMgZm9yIHRo
ZSBoYXJkd2FyZSB0byByZXBvcnQgdGhlIHByZWNpc2UNCj4gZXJyb3IgYm91bmRzIGFuZCB0aGF0
IDFVTCA8PCBNQ0lfTUlTQ19BRERSX0xTQihtY2UtPm1pc2MpIGRvZXMgbm90IGhhdmUNCj4gdGhh
dCBwcmVjaXNpb24gaW4gdGhpcyBjYXNlLg0KDQpUaGF0IGZpZWxkIGRlc2NyaWJlcyBhIDRLIHJh
bmdlIGV2ZW4gZm9yIGEgc2luZ2xlIHBvaXNvbiwgaXQgY29uZnVzZXMgDQpwZW9wbGUgdW5uZWNl
c3NhcmlseS4NCg0KPiANCj4gSG93ZXZlciwgdGhlIEFSUyBlbmdpbmUgbGlrZWx5IGNhbiByZXR1
cm4gdGhlIHByZWNpc2UgZXJyb3IgcmFuZ2VzIHNvIEkNCj4gdGhpbmsgdGhlIGZpeCBpcyB0byBq
dXN0IHVzZSB0aGUgYWRkcmVzcyByYW5nZSBpbmRpY2F0ZWQgYnkgMVVMIDw8DQo+IE1DSV9NSVND
X0FERFJfTFNCKG1jZS0+bWlzYykgdG8gZmlsdGVyIHRoZSByZXN1bHRzIGZyb20gYSBzaG9ydCBB
UlMNCj4gc2NydWIgcmVxdWVzdCB0byBhc2sgdGhlIGRldmljZSBmb3IgdGhlIHByZWNpc2UgZXJy
b3IgbGlzdC4NCg0KWW91IG1lYW4gZm9yIG5maXRfaGFuZGxlX21jZSgpIGNhbGxiYWNrIHRvIGlz
c3VlIGEgc2hvcnQgQVJTIHBlciBlYWNoIA0KcG9pc29uIHJlcG9ydCBvdmVyIGEgNEsgcmFuZ2Ug
aW4gb3JkZXIgdG8gZGVjaWRlIHRoZSBwcmVjaXNlIHJhbmdlIGFzIGEgDQp3b3JrYXJvdW5kIG9m
IHRoZSBoYXJkd2FyZSBpc3N1ZT8gIGlmIHRoZXJlIGFyZSA4IHBvaXNvbmVkIGRldGVjdGVkLCAN
CnRoZXJlIHdpbGwgYmUgOCBzaG9ydCBBUlMsIHN1cmUgd2Ugd2FudCB0byBkbyB0aGF0PyAgYWxz
bywgZm9yIG5vdywgaXMgDQppdCBwb3NzaWJsZSB0byBsb2cgbW9yZSB0aGFuIDEgcG9pc29uIHBl
ciA1MTJieXRlIGJsb2NrPw0KDQp0aGFua3MhDQotamFuZQ0KDQo=

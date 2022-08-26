Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C2E5A1F74
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 05:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244703AbiHZD2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 23:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiHZD2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 23:28:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1552ECE33C;
        Thu, 25 Aug 2022 20:28:03 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PLJnpo025351;
        Fri, 26 Aug 2022 03:27:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=9231MMRzjwEMO3tZpsb0Of/GWqfuKh5oCSYvCTfjT8c=;
 b=Ank4kvOmksKgUgCw1teVw4+T0CorBup7O+d5aChIAhnS6z//EWQpgrmRsHdo5405T7Yj
 Zci4e2vVowsBuY89y97wDZHmF2XVqg9jV/P4a7ttFGLxeqJeyxZbHlz4Gj0jEB9Vgec1
 LZMIiH2P+ro+SmTlIANZRGRBxQkQ9vt6b7LHlYVOWFqBB4QzVYvgfQgd5KDkYsrOGqOq
 ZZlx3KhW1eqh4IfK4B6qG7t1men4fGanYoOoUEmRApTJWbmwM0L/20//zw134g1tufq0
 utYayQaBOd7WRchaohPcMZPHXVrJuQFw+5ERN22j4/OUwDO+aWDmfFQuqjH+k+ugwGpq lQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w240fw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 03:27:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27PNWkcP003549;
        Fri, 26 Aug 2022 03:27:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n6q9mh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 03:27:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTZk61VFEX3A47DreuPCnXLw/ctvaHnRHDDpzyhsX2uMmRrTwJ5FDxwUjptzulUQOB2coCWE+578yyMe2ktNWgwugcNTa8YrKVBzxR/u3l18o9oEhs3mNQExajyBWWMicU3Ry4k94pULQNcr1sZQYN3tG96tszw2B+i5MusLE9ZrEAXra9IrmjYkfCsBkDfQnsSwrZyQheElOjwGoaDuFGsViyH8ue8vtv3TDGZi7RXIoueY/VbsG3Adzj+h9EUP38YTcsZ+IJDkJPm5fIoEdNyrb6IMylm5KiS/+7dvXhsv48ZtZJEah1koziOfF0ByiEpXi7BFaxkLcEMBxAuRLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9231MMRzjwEMO3tZpsb0Of/GWqfuKh5oCSYvCTfjT8c=;
 b=Nf+Y4kW6fEQQraa1fg6LWTAEIyyxct/6wR+1UdQUCJoXR2J5h/QoMSX6nJRitH7kDBoArIBlIBK2Dk/d2ulYi7yhwYUATL1GDzH3UdHOV06E6JJr8lnhxbKlYt0yxcKS+eoaSKGMXRxz6FuiALtvyTiqwvHCI2mWQuV+LsTO4OaMRB4U+PJOjSdbns3xv4e8koMHp/CnhVz+j38ntgKMJiUosxOw7CEfmI9hNFtT1AocRBAr2EShh/ay2XXbL7p0WBEF/8FTU3E8pENxbKJ5HJcE0zNtCoDSVkG3XoqSE1iqXnHmbtywa95x+zEhAoxY+qaaVgC47jGxYmj9dDGyAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9231MMRzjwEMO3tZpsb0Of/GWqfuKh5oCSYvCTfjT8c=;
 b=LSoZK6RljrwYlxchst4XtBNEKIlJxYuSGduXGILLCpPcMHfHAnj/t0Y+arisc2RX0AX14qRHN3qf8QCJj11aVRBYsco412dk120AoZsM27enqmAvy1x2FRjRTUnAOCiaK+FX3LIyVJpeaASBjt/vZkNg76z4DHAYCxoGL75R5lI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1526.namprd10.prod.outlook.com (2603:10b6:903:28::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 03:27:34 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.025; Fri, 26 Aug 2022
 03:27:34 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] mm/mprotect: Fix maple tree start address in
 do_mprotect_pkey()
Thread-Topic: [PATCH] mm/mprotect: Fix maple tree start address in
 do_mprotect_pkey()
Thread-Index: AQHYuMGBdhRwsk8f20CcW8E/VYXZbq3AXpAAgAAndQA=
Date:   Fri, 26 Aug 2022 03:27:34 +0000
Message-ID: <20220826032728.c5zw3bh4pmbz66dp@revolver>
References: <20220825202939.3041660-1-Liam.Howlett@oracle.com>
 <20220825180614.0ea05648f898bfa17f95a83c@linux-foundation.org>
In-Reply-To: <20220825180614.0ea05648f898bfa17f95a83c@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e1be8a3-5fb4-405e-3301-08da8712eb0b
x-ms-traffictypediagnostic: CY4PR10MB1526:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5UVFuTjR6zn4lP39qR6F2yA9w9LZ7q8pZ01ypntH0JDY4NyMwX37xZe52X5cmwzloWUyEni38DUOM23ROT/vJHx7n7GFbRDOwvCY1zmw1H6BZjVlZyonF/pgGrsWhHAL+5l7K6xk90dU26FVLXjKf1P1KRX1Mw2HcyuRro6CROn26XjB3lRZti1RWsbpVr9MdxqYpZTqx6WdHiAB4PiwBU6vN5sz2fpPO/GhHBI47RGhythyF0GeBJgh6zvgSH63M/pX70HiwgApKqzdb+9fr1LZRndpUsi2S8OTbBjhV88HN4kGuLZIrcLOoI2Gicm/edSNYAq61IagrHEmX45XxZePvymYGv9bnGq0FnrX2Dsk/b8DxYtnbmDthsH+vpUu8sZQLdvmIu6HRK4ZsLL2a7Nsl5Zn6HGFWKyo9c45GfPxM4IJOZeMIpbTVDVl6eY13SM5Ui/nNrSxNjgZYoLd3ZSVm7mOH5SNtMrBGvPS0WziV7NZqM73BU3bUxVzV0+zbD2nxSS1QmIkqPAeqH4vyVo78IbH97XehpicelYfkxb4mGGC+16mEWDxoDn4IxDqwr2gIkbwpbCaZIp5hM6SQ5pn4A4j0MSGAJgJtcs7KH25b+2lgyTtAGBC7bjSP5e7dXXRhH9YzfqzchKpreIhwsEFoNOYwkMuXswhgi5OpVsPfHOt7PycJXq8EPPErhpDh4EI2YfCubxFKCQcAI2Rb1ATHDFCcJvylBbbwYw0/tpjdT9mXs2495TSb30KRtxR+FcVrcEKsCYbrQXES2Dy7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(346002)(396003)(366004)(136003)(39860400002)(38070700005)(76116006)(91956017)(38100700002)(316002)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(86362001)(122000001)(6506007)(6486002)(6512007)(26005)(9686003)(41300700001)(478600001)(71200400001)(5660300002)(6916009)(1076003)(54906003)(33716001)(2906002)(66946007)(186003)(44832011)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4593iOLWspXJUeKGPQ7aaeeokLAiBbSSOB8hYOcfMn64AsI6uo9il9cWXYEr?=
 =?us-ascii?Q?oBSmpxXhOIqwqlT7cV2PNcKKll9xEhj11br69FY+Q2ms118MvljB8shjm8l2?=
 =?us-ascii?Q?NcF8MWhQD0lZsCDWjkbe6eQ9A7VNQFvycu+m4zlTNecvlN8ZNn1s3zuSf9RA?=
 =?us-ascii?Q?EstTQoyZZfw8N/oRb6njA8nLvd3L+/hmyPYMD/zat4wr9rxaocEkc45T91j9?=
 =?us-ascii?Q?LqFS/DrWTzGw76x/Aptfj33ktyDochQjXWNUbHyUZZfVLANOnU5URjcmqg5r?=
 =?us-ascii?Q?3YRPk4PMctOkmqWDaC5RhYCIFLQJfy6xQcf/V2LjZ/uy6se+MudDM9Ae2F8N?=
 =?us-ascii?Q?M2G1P/EscMs3Za4NFsPzG6D4VD/ZWEPLaE1X4aPO4m7bxX+0xJqOgxO7Pcuv?=
 =?us-ascii?Q?eObEa1xiayQPtbaV41sL3CT9aCUtJyKDEbBjc0EQ9aOpY2weLLZqRiKgfXWH?=
 =?us-ascii?Q?iWsONi+QKnmsRZCHDsXMCh/QPd3G2qahPgCJPPz8K5QkQlMvvzWWiqqclXoa?=
 =?us-ascii?Q?cLLm9bj7phtLIJx2Tyd5JU3qKylqlG1cUhywT/i6lJ0S0gLHXrCh5e9p2cID?=
 =?us-ascii?Q?gHzmB5NULxUfgR9xpW+jruazVIlXuzfTPbgkUeQeGgQML+s+BqVQamE0O2TX?=
 =?us-ascii?Q?+MlKkTOw3fhZuXiQ2kN0UIaaUlGWLurAVzCFIR30hRm+Z2ENYhRY89je/+7e?=
 =?us-ascii?Q?drehJBvZwyf0hCoGgbmTfDoXNJRijumDJ0dw4xx+wPhmGfpMhKN1NHRc9pBX?=
 =?us-ascii?Q?wTX9CpPWtMypE3W1Is7GZ00LLHHNIO560wMuXBcda0Jy+w0Jbw24wtCC/Snm?=
 =?us-ascii?Q?xQBDyLXAzSiKuY6pnWq+ryOeSQGgDliN7WAqyUe1fCN5cyEAl34t/kQ3NgNs?=
 =?us-ascii?Q?+LQaXclKaNWem9ONfHqxq7OvwUi8wMLCPOTpk1ZSlMZdkGbyiA3jUoV5hBGq?=
 =?us-ascii?Q?uq3r+MkkxqwcP6Z0JlZnEEYomkViP9j/QzlgCDps7JcUK0lQ4w1ppuzU4gpn?=
 =?us-ascii?Q?v7pmg0lYPZRkWd7IsJYRjTGm8SGbjug+MesHXjTj04IAVxRM6hkC5+jdSCIM?=
 =?us-ascii?Q?7rbp+RMgn6qroZsALEVJUXE1hlWzWsfbPqxHg7cdfrnc8LCccgOt4ec8cq1Y?=
 =?us-ascii?Q?n4ypdrf+zCAaP103IFDnPjOTuZTae+d8PTfo1SCcurgivh3KOc+2dj6qz1NL?=
 =?us-ascii?Q?KHlumQjl9h1qX/htV0Vu1T4VwchuFi6Nxcuy+4+hFOXiMuYlIoz3qkAPRxpW?=
 =?us-ascii?Q?nrI4f6wZOTe5kZl+d7n7WfCxoSd8wqBv++tuzb9y7kZbrYALAXAB+wninhRe?=
 =?us-ascii?Q?4pI3zwueK1oMLUCIK2fIC3bNVjdOiPwKCWCEDLvclvspKu8wPpqfm++vdE3x?=
 =?us-ascii?Q?Szpl554+MGNtmVSgUkg2BY/kAEFOyXpvfbEmns/HCLi76EzG9GcP1HTXCHVa?=
 =?us-ascii?Q?n9uaf3AvLKBHmh0U8moS3lHPGfR/TUq5gFjYIdJ02nmmD66EaQtLmnFUQSTB?=
 =?us-ascii?Q?lIOf+Pn9Lk3Yh4uEUATcOTshSF1qSYZy1FGMFIi6oUJIpv9X6kS4uZLLC+W6?=
 =?us-ascii?Q?O9iHYtNrLnLaMf325Afl2kE1mE9psEmBCqRvHgVthdfcsxaKJyAMXHibYJLK?=
 =?us-ascii?Q?kQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <227882FFBBE00F4EBCA516DB049EDDBA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1be8a3-5fb4-405e-3301-08da8712eb0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 03:27:34.8574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: udlc3ZkF7KCkEG/ej/Md3YcIkF6UgErBJwiLwkQgv+MwmVRzq9FkgTDHXomZXw/Ru/zYcf6Up5jVXWCh8YQGGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1526
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_02,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208260011
X-Proofpoint-ORIG-GUID: 9mm9F1KuV4jPscMFFy0kMsGXcbPSj8dY
X-Proofpoint-GUID: 9mm9F1KuV4jPscMFFy0kMsGXcbPSj8dY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [220825 21:06]:
> On Thu, 25 Aug 2022 20:30:24 +0000 Liam Howlett <liam.howlett@oracle.com>=
 wrote:
>=20
> > Use the untagged_addr() instead of the address passed into the function=
.
>=20
> What are the runtime effects of this fix?

Prior to my change to use the maple tree, the start address was changed
before calling find_vma() with the untagged_addr() version of start.  My
first change recorded the tagged address and searched on the incorrect
start location - which would have found the incorrect VMA.  This fix
will use the untagged_addr() as the start of the search as it was
before I changed the code at all.

Any penalty of calling untagged_addr() occurred regardless of the
version that was used.  The search of the maple tree would have also
occurred in both versions - just at the wrong location before this fix.
I expect that the execution time would be equal as the search on the
tagged address would have either returned a VMA at start, or the VMA in
the next slot in the maple tree node - probably immeasurably slower
since the data is very likely already in the CPU cache, but I don't have
hard data to say either way.  I can look into a benchmark to measure the
difference between both working versions, but I don't have an arm64
native target so it will be emulated.

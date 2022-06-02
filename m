Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A5253B82A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbiFBLvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbiFBLvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:51:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1760179087
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 04:51:14 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 252B9n2k021194;
        Thu, 2 Jun 2022 11:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=kLY4lN9Sik52ruf1qJXF/91QY2DeS0kYmX8jD2QFT44=;
 b=oGHcJYVnIFuSMTn/UuBCqfH7/rouPuzbriUdhpI25PYUuGQHsssrta27C2FmA2LC3tG2
 uU0f6P1tt78jRXKUnE3Z9a3aGuaHoNwxgv6Yko5+VuW2p2t9sModm4Mq98+CDG4Z172f
 UXFUYDo7vgvw/nQ4q85+lRO4JtPxyiw6iIERT6th8nvjxtsOxHQY+pblAcmm2kMcreCr
 xhyUdoIjpGaugfoeq/hEmTpkv8QH6xeNzRGhpxfg74vHUfxBSFntGxAZBQ9qiwZJP7RW
 NuZGJjisXI5g3FVixJL+C1VuuiTqv2DYDit8VC76cw1SHm2P+sgzJXWCUoeNz3Mn2App fw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbcaht7gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jun 2022 11:51:10 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 252BfXPg017741;
        Thu, 2 Jun 2022 11:51:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8k1c95y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jun 2022 11:51:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4mmbE6oizO3YXSgAYj3L7m8kafXPDz6biGKkkkKpBwKdIUAfwGYsLE1j2aySlg5unLB6qIZ8c1TvNY/K43sYmgFMZ5IRwXOKXgAYquyaQf9urAK6aj2F/iY/5yiJXw6PadaO//aoqJKEWRT2kQy84YCnLnTZhD0HM+gUp6fW1mxveDAUmU9Dl7hNABpyWqNCXUFns7cUZL2Sxly3dal/c3Fuy4SvExSJ3cLtkhDxnXCU5ZNiXoqGMgKOXJkupnBXjQt2xSJnUuWib+2eIaddBmlWpQelnJa2+QZ++CgsF07C3zKVRvva9xCpgiRr9g0AAuAkMpE+P1AyGj6dci8KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9krDPlLetjDzlSEHbt9P7Oj8f0mqu0uYtklrRPm4KQ=;
 b=LrXTNxk6rTVw3m2dXN7ti5JunyC7EBsTgEf65S10a9KHOT+zuGU+ui2/GAXnsLy43Xemp8xorCd/KXRwT3nRiLr7rZFl4+ukXrHRBr7+530wZPcIVM07H3TtEfgq/jn2eJ9PkwfdD2YcGEm68/cFHmsVTQiLuxEN97Wg/TKP6zd7lboWiqGR7ymIDYqTlPIx7eLdauxh0KMthm2Q7ZzayIg4fhanMS1L/Ba74zbxL7MjHjcOUZ1Haq3eh9k7EXcpNDJTDCMNAqyZh9VzYQ6eKVLMn5w0QywwqsD2PYh2PkUy3ebkwlxw0U3D9gaGtOy2RYrlKlk5aYRtqsUGhAJEaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9krDPlLetjDzlSEHbt9P7Oj8f0mqu0uYtklrRPm4KQ=;
 b=SIOWcBN70uBM5BGHrGvqlkNB848LwG+SbRRXUUw2Q7xf0zBdJVCsY0a7IKDNJmB/2/xTm7vlfdn2/xvN0vflu0oxF/t2QF2pWbrw8x0gbgnA815IjPBdAUDdbS+lHO/RkIthfXh1qlffZe5u6AuRHcksRVDZX5fOr7BnmAzK5I4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB5138.namprd10.prod.outlook.com
 (2603:10b6:208:322::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 2 Jun
 2022 11:51:05 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.019; Thu, 2 Jun 2022
 11:51:05 +0000
Date:   Thu, 2 Jun 2022 14:50:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ernst =?iso-8859-1?Q?Sj=F6strand?= <ernstp@gmail.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>, kbuild-all@lists.01.org,
        kernel test robot <lkp@intel.com>, kbuild@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [kbuild] drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1433
 amdgpu_discovery_get_vcn_info() error: buffer overflow
 'adev->vcn.vcn_codec_disable_mask' 2 <= 3
Message-ID: <20220602115046.GH2168@kadam>
References: <202205271546.oV14N2r8-lkp@intel.com>
 <CADnq5_NOkqRsoqELkLayNU+xArXd-4RO=_banvJpXHtSW4-YdA@mail.gmail.com>
 <CAD=4a=WRbp8w4DA2c6hE7W5A2-woRyHLvtC-GPitFwQireCeNw@mail.gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=4a=WRbp8w4DA2c6hE7W5A2-woRyHLvtC-GPitFwQireCeNw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0028.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bb4346c-885e-4c59-6f96-08da448e2cad
X-MS-TrafficTypeDiagnostic: BLAPR10MB5138:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB51381B0948FD3A2616BE13A38EDE9@BLAPR10MB5138.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z4spK+Gj6xP56hLD+WsKiu8I/vNFmw8C964PCZECAkBcAq8+gw1ghF9zocrz6N6fejJDOSkSpcR5qcQncoyl4VS3ojHFr6wg/V0jRG5JTp2e3xupYVZQg2kwsVV/nzllXOYXLTEsPAa5Q/BGrRQnqs1uRTmPgu7ze44obJXI7iRUamz9M2Q1/0p6M0wOWVo1SxdMj91Phr80AHhEBYPoF8K285oLa8+BXcXYLAxM9gFf8oUbXDY1xhkD32UsnPHcOwctpxUaee35cpUZg8aIuBD48TrBzE4DWzZSneg2RWzVddAlTDnKpAGDhYNPuKrKh0iC17fHIywTg5fVT3/Q+6WxNUj5hXPFIh8o2b2/Y554YU6mNJMaUAO+I9+0/XHSb03uWXDQJ9liTwvy155AoDZMKafltXzcag/HZUIys5XIos3Vc+ocbTBRQNy0yRAhJlLCj3O8oV3IRufcynYegiqlyfPl8YX1dfPgrUOHK2Hx5lW9BDqdbMByFwRV4n6P21EqlmhO0g5br6ROw+FoQsM6r46KUP9BTfRrNDhFjjoTCQn3vjqEcMR6a25VS4O8aaaK3vw+BtK6cQlNi2SyPw4fqSXSwgjvGSyFbWwy1aSA6qEpgXOaZZlB90Tbuw4zS7T7wh+UYMEpZ17/4co+7bYrUFVwiX76Rumcqg1KzjlmRvRb1tL8XX52NDhNKayP15tD525CZ9QVZ3VxlGmUGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6512007)(6506007)(33716001)(6666004)(9686003)(66476007)(66946007)(26005)(52116002)(66556008)(966005)(6916009)(6486002)(508600001)(86362001)(316002)(54906003)(38100700002)(38350700002)(8676002)(186003)(83380400001)(66574015)(1076003)(44832011)(8936002)(4744005)(5660300002)(33656002)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?4I8s7+EKlIlNoC2wBH1s4jXFdYbdNtTKBer3hG7bFPP4mN3xOBHhHSjlkf?=
 =?iso-8859-1?Q?/X8vuY8B1SKRgAJUl/yxXSR0tS7Bqv9cgq+sMap2lQ9PbQv/RmADiZlnFh?=
 =?iso-8859-1?Q?J1pF0RDN/wtpsttulqk6HdnEgNxhc58mYTaYIm+uYS4AD+aXdayjPxDJog?=
 =?iso-8859-1?Q?J1Ar6leUQzFNy3VPgqbZB2669ycUg5MAhWZoNHv4artE/sJU+bRgjc/6ct?=
 =?iso-8859-1?Q?XEB9EeQ+36kelZsn467QLGhnmVos3VJ0xKDMsir+xhydGxvAolEz/WVEc7?=
 =?iso-8859-1?Q?6oD0n5y09xya3ZYeWmeAH6P9IttTpkSY5b1PTu0oos7XRWoivxddRM6KbK?=
 =?iso-8859-1?Q?8vbd+NiWjNN3oFH8T7oxEzRzVAR9KJwGb8uYfRcNSJcbaDeSNvWcTOCHoi?=
 =?iso-8859-1?Q?T/AJk2KNKOqSIYMBhTiLYSnp/eqt7TwufLE3rSiQLHxetwdOuvC0jipdCB?=
 =?iso-8859-1?Q?9qosuNKUANP43ONGiOeUDiN/uzsBTujyyfVxiB22Ih1MpV2SkDwIaVuxDJ?=
 =?iso-8859-1?Q?J6cICLY5suCFetYevjtIeeHpiS2gk2rRWpxQDpwUBnDk2KTbTI6WEADY90?=
 =?iso-8859-1?Q?d8oASGaEc1LdXhSFcv0QSU6GR0ASaA1kkPreajw1qUS2n/MFmCRwH3TBWB?=
 =?iso-8859-1?Q?Euh9iSCNMhzvIO+kt1nrYmDFGXlJNzZiglH2Ihn358fMuy6XP79XeaOg4p?=
 =?iso-8859-1?Q?t+rgxK5hZv8U+cjfTxfYy/Uj5fo/JR9svuf7ztZ/wAaXlqjTyh1su56XwK?=
 =?iso-8859-1?Q?xJGnKvaeLBykQKyBDhnQ9jU+g8drih+m4UfvRb7rFSD5fLi/gZN+/QG7iw?=
 =?iso-8859-1?Q?eC4bP7sZVYV8XPHaI3BY+m4WSCAUj0/D1ecpZqMWGgz7BXmqaJS6fFQFfl?=
 =?iso-8859-1?Q?95yGNbarz26vaOsuFi6MPD+xk2CEGvn13YMAbhy8Hhzn/H6eP2rKZsJ0AB?=
 =?iso-8859-1?Q?NGDR7OaWza3r9Z6kp9r6Zvr53ZvtVKqlmXFvHnHpOgCyxKMvYq9GHxo0A6?=
 =?iso-8859-1?Q?bVRvkGVcD/otbPbxyV1HE2qwT6Czjz3ZqRwaWCvajv01hA3T6IV7ctFqT1?=
 =?iso-8859-1?Q?CNQ3qIbF83/9pJ492wxNV/xaD3UMtlepYgaL4fgaiqaQl60UuJFY5YbjUr?=
 =?iso-8859-1?Q?v6tiveVYQ4hEWSNj3bgtIZPjrMV2FfypCWFk1mxFIacgpMwrNWmau7BzRy?=
 =?iso-8859-1?Q?4tenMWCRrxAmqL9OSebp+/Ncv5tBsvPraYMaFBk45MHCKbcnIjVDvDN/tS?=
 =?iso-8859-1?Q?KRR64r6u1z3GEDIQOJOgG+QGsZ7VRGr7tXe8+gL40arSfgPwg1XnXLEkhV?=
 =?iso-8859-1?Q?xxgRXHb4UD6bOpLnXh9KkXmxMzs9J+NkHCcnY5XDHhmpp9sBVCIK1xqKlc?=
 =?iso-8859-1?Q?oSkzx+nrgza72QGWZqV8AevqfcgTmC/4ZNWLZ9JPtQGBLlAoW4jfyAB3qi?=
 =?iso-8859-1?Q?dQVA7ixbC1gLlBzD9apB+2+PR9e0U1rOslz7WF7nGxjWywQ9rDOzV27+/H?=
 =?iso-8859-1?Q?7prZBNhSpskUpRNBvBbJuqDWuTBY2YUA/t8WPXT1fT9Rzm4mVMSPN6ClzC?=
 =?iso-8859-1?Q?GEcZzxIdV3octtw2tRzl4EzM/P4wLmGzYRw2b5E4H5WkC/Mb5ezNmVt3fp?=
 =?iso-8859-1?Q?+Oa+1wkPNLkZGhNaDOosalXBaJWiNB0yXdxhNarPn7UsdeCNADbRGnCRK6?=
 =?iso-8859-1?Q?ujvfMXdaUvoF6cU0ESMIaePJKT8FyV6TUmCg/k59ZF4ACUNc8V2VaUJU1z?=
 =?iso-8859-1?Q?x53zE12TiQ1N5rvjWWHXjsTGTonxx4U5TsPcEFkyG7PvpZFr0O2Eek1chF?=
 =?iso-8859-1?Q?TJe6RdppN47uc72Xn+jUKyomZ0sHC8I=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb4346c-885e-4c59-6f96-08da448e2cad
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 11:51:05.5392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MyC2nGk0vr3/LA3sXfSVkHywMVoy8rqbEkASm9HLSzc/l0A0yDLd7CanaXc9QZVcgGJaQ+n5u1Bv/N79F9twv7HDC1yQqQTxPJPzrU2sIw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5138
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-02_02:2022-06-02,2022-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=794 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206020050
X-Proofpoint-ORIG-GUID: in2mBRDNc4Cp0RI0aU564SfZ6N-OUreh
X-Proofpoint-GUID: in2mBRDNc4Cp0RI0aU564SfZ6N-OUreh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 08:26:03AM +0200, Ernst Sjöstrand wrote:
> Dan: I also ran Smatch which resulted in the following discussion:
> 
> https://lists.freedesktop.org/archives/amd-gfx/2022-May/079228.html 

Since the bounds check is dead code which does not make sense and is not
required, another idea would be to just delete it.

regards,
dan carpenter


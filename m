Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1784FB946
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345247AbiDKKV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345241AbiDKKVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:21:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B498204
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:19:11 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23B9ruad008564;
        Mon, 11 Apr 2022 10:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=G/mTgcMrs0GZwKURDvVgvtJA1PZ+ilpj8/6T7XhAd9M=;
 b=OZ326YKFYaj8zD9tk5OVbDm3SM6yzhnoQUPGkZ4IQpHp2PtXjx/xvhBeYNjRB2M5Jjzp
 rAjery4ZOcV4TbqlpBEEFqBJ79jBymqmufA7hr55qeI8fiDseI2Xq6cC59kUFJGz/+RP
 QxlRvwdHS8Qf0bXc1rL2G/hQwsZVMHUo5WHWlFW4/p8e1bmbDMBq4RHHh9BKfIOi0N86
 ognCEd7Duyh3heB5Uo0G4TAgXEeTrDl2iJMoNEtzv68P5XuMH3loAQ9ni4IlAi/sUU+v
 EWAAUAs5A+V5H00WoJiQ1L+4fYhXqpbDIRRohW5LvnSgXx1SPdaEz5QfoWlkaxir5vmh 1Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0x2b76j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 10:18:57 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23BAC6YE036797;
        Mon, 11 Apr 2022 10:18:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fcg9g3mya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 10:18:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlXU0M3ft0/vLfVxlU7vnnl2PyHxqOtYQLbN88nWjL/CFR2zcKu8f4aGONESdikrfVWAZ5Or/BVYT0vcwAMXIi0n1/HSa2cdwmpfLXXMunK+27ja7LrIj7yOyPOw4bZM/pkqxBkuTz2b1BKIkaVbSvyD40v+IgQQyvP8eFijiXwqrZPOn1v8W97jOGfhio8miTh+noZ1qO/QRuOwMq3OHtC/8t5S6hMXvl7Mp18bxAWyrdXBx+7uSo1tP71XE5h5uuHhqHBHCPm7F9QcuFsXYWG/76AGOWhgAop9yMGYROceGEMGMqoInr0te/pOWKgD5T3nqq8WjNHqu5+ykGzHww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/mTgcMrs0GZwKURDvVgvtJA1PZ+ilpj8/6T7XhAd9M=;
 b=aiF+4rGHr2mDXaI3CBl5skxGbsEh/6VJdCbBDtAVjWsxRY9KkuxKTE7Lpm9qkOL8RX8i9q1QCiBUO0rncuPBRleTgH/igbI0kWJLntoqHOaH3OgVW7+a+u0KgcF8XFrgNX1QDVN+hGsn5CYFCkz/uxf09nIL49JYwEQt2nXGQJqwtELwjSMWj8w/1QQ+KYwgjh8d+AkbRQF8xoyPn07Q6/Sisq2Jb3tDK3MPJM2skZEcR+aOch99jQa1KvqXjLW6psNZbHZ4mcTun/ze0eq1sqTmAkCMXRUXK/pwy1o3onVkVy7JtpWvJMqCUWEOuxSNRAR+5qG65v+GlSFGm7Ja4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/mTgcMrs0GZwKURDvVgvtJA1PZ+ilpj8/6T7XhAd9M=;
 b=XG/60RIUF7cA/cg7BeyjuDjDXsL9NNjF0Uoz3RPQlnnjqEHbRQzYG5VY5Yq7EKoxHur1NYMQd7NpYTlCbLXl29GJ4ZHK3helg9WHjhCspF1AoqA/ibwALoaaFL1Rg6JyelsU+cC5XBrQqwmYjbcKja+riweGZNPFHnijflNCVSA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB5647.namprd10.prod.outlook.com
 (2603:10b6:a03:3da::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 10:18:54 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Mon, 11 Apr 2022
 10:18:54 +0000
Date:   Mon, 11 Apr 2022 13:18:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] staging: r8188eu: don't set _SUCCESS again
Message-ID: <20220411101834.GW3293@kadam>
References: <20220409151557.207980-1-martin@kaiser.cx>
 <20220409151557.207980-3-martin@kaiser.cx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409151557.207980-3-martin@kaiser.cx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0026.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4985d4a0-9cab-4a55-7506-08da1ba4adfe
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5647:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5647AC8E6BBCECE37F4A159A8EEA9@SJ0PR10MB5647.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vdflSPAQYwOJz9deioPO6Rvuz9cKzR+Hx3lzjFdR+JJJvRKz3Zm7POvrYtt4/PN0Aj0XZKQy5F9Z+UWYece1lYyH14bZWV3L2BA1NDGSo0XpSnHKYqUCL4qX3kxwJPjVwR5LRabNBjkVIp0iSqNYThyMF6fTNwICaoFR1jxeZx0GZ2NyFeljPx4p69NJ/HSm3dsksH9K/C0DtSEUTXyYN0C9g80gOueli9WRF2hu/IndSFvr5VUoN2yio4Qbe/xKYuZLxJH/PPucYFP24QERU5FwugZLqy9HtTW1XW7pv6NrP9MEq7QhPeUHxnCZWiotBGDit37K6Z8nt74EbBmfClH+hJJAgFpbcgnoZw99uwDCmDaJVHScEAnRh8pYZsVRNUgw5fUh9Omz0HLEWOgo/J4L1m75KRLv1DlX6EtOzKyY6wlFg+SP7DMuR2bibkjSU/qSADSRbdy6O+UNLCmcPik3X8/ROfGiKIcVGA8Lmbw3pHo34Tuuf4azqtIehWi+QKpBX+cm6PH70ZJlhpdbpbxIvbJmorU15fvagAX1EGnCI9KYJStITk661DsitEzfP8KkOkL82SjKrddIBUbuSi7WwUxhcF3FP56saKhdgysxfhX5VMarUvqN1jPAPIP+IBvI4tQVGzxx8hppkrm1POwJy1Uf5fnrCd6uZJmdW/7N9g17R8ZXqbnznS1faDLZGIXHC4RHi52cglZ05iGOuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8936002)(86362001)(33656002)(38350700002)(38100700002)(2906002)(5660300002)(9686003)(6512007)(66476007)(316002)(6506007)(52116002)(1076003)(26005)(186003)(33716001)(508600001)(44832011)(6486002)(6666004)(6916009)(4326008)(8676002)(66946007)(66556008)(4744005)(83380400001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TTjNV6iHGYDZkfLkOoJxuR0HeR0z8K7h3qooPwWv5S9GUZCDXa3FgEHL2792?=
 =?us-ascii?Q?XYMph+rNKnARbD6DxfW4j+A47lJ3qs8SjvZDS/55loFSlculcw4GXsH6ZYbI?=
 =?us-ascii?Q?NPdkb/wTkWRCt1Wr7vvQLIHYONCo7fKHCm8tegr4adwGVt5UZdirAADV2cpU?=
 =?us-ascii?Q?fpveUtVzDSRoDKc3GOVYmzJdvPSCi11PIF0XWVApN8Y/AaDDKsSNZOZJXkS1?=
 =?us-ascii?Q?HXtvzAIfFShb4bnmyoeZUthn164Mor5TqAwprZwG+b2aQaIGK8V/hBAOAVId?=
 =?us-ascii?Q?uuem4DHPtXI51UghmakyHkjR/AwcUa9zBEJfQY79PDjy+darwYTXTRhrS06e?=
 =?us-ascii?Q?TbxYeSOWUvL18J1HCH3A4XmqxPHa9yPovA4DiwZd2yNUnr5+B9YohivBH0DA?=
 =?us-ascii?Q?HDNk7vMBpiuhQxITuZQClyPyQcYiq3CE/dyzSplxgiBwdHj2ct3Iz3KqvHRx?=
 =?us-ascii?Q?GUAf8PFQsK+BBzKhohijwriorGBy0sEhHdvChywBRKTVJ5PbrdneW6OB6bAi?=
 =?us-ascii?Q?1nPZMI++Hs2EeLWaTBmvIGCdv5Ag0UftlulTSdCoBqqVKYqFOV2BQb8Y/kc9?=
 =?us-ascii?Q?10mZGsbduHOyr9zzn8q8IyfZdls7DBRjyt5aCARgCgStmR4iIbkMlG63LBNI?=
 =?us-ascii?Q?Tjkh11goVbxKr2sLKZbYE1mzvodqWHb19bhxDmdLOuhejMfYIJ5iD0oFPBQG?=
 =?us-ascii?Q?h6xwSA+F+sjPsnA/ouhLTxPvGIzuB+U+UpwPYDgxjfQfeydBy58EVO2S2vul?=
 =?us-ascii?Q?t0rrENqrlIuczKsLkkTonj4lTyi1afynY7lWNl8r1bfiMpwbeKXctPUajmS4?=
 =?us-ascii?Q?L6K8EPWcWywi1Xmp6GCHaoUiHG/hJ0YXXgg75//zeRv5vo9MA4SxWZcGQm4J?=
 =?us-ascii?Q?5N2sgew+uhQtj+WhGRVXJJbmxI1jFTpIY6y39M+wKumzCK1RTU+nDZM/0GH1?=
 =?us-ascii?Q?OP7DZA51b/9TgMQQvtwYcZKU3usHEmJATM12SHSCD07waLKDZHCfMbCUHxno?=
 =?us-ascii?Q?0l5o+4YVDLA+HEkyk4drvGN4oZsJTey9xqEiHP+WR+Lz06Kuu1FkVf9ynMhE?=
 =?us-ascii?Q?XoqakVlUf8REbPg9nx/eIkHAdiNf0wJATLW8duDyvnjwjvFncr52B3eQ2XI4?=
 =?us-ascii?Q?bS1YAK1KkwduHM43/JPiUv2L0tnnGHvL54/Q09LPux18Cauq+RcxrsnGdtRg?=
 =?us-ascii?Q?NKR81bd64s+84h/omHRrtd9NW3z5mzV0h6xldu22rk98igGA0JdHXrMetHVZ?=
 =?us-ascii?Q?qyWEV4bjuAgrKop8QOFnTn4mFTg+mIJWprveEXufHALvMF4aIxQghKbK1TUn?=
 =?us-ascii?Q?tW0XsIl46Af0fa2SNyX9Bmg71mpCAD/jLnSpVEY4zAPpz2Wmu381dbsGPSWO?=
 =?us-ascii?Q?v42gRWCz5bExFvfz2owlQ54GhuBs78tdBLU38thRFDad/f+JfP++NDlMPEDr?=
 =?us-ascii?Q?jYJgB+k+40jDFSZnOf3woSWxkyxZS8OZYgRpqOL11FQL3pjAUfOEDWOU6ydk?=
 =?us-ascii?Q?K4Wmbf6mtp4CZQUnbWaRfstvidls2XDpzqlxe7RepxiE5DdjUiz7bnvLFE1c?=
 =?us-ascii?Q?+O6owgopDEl4I9VcQ515ObzOcuV4x2cLysdGHXUKcyAcwPSGoW22FWv3kS8K?=
 =?us-ascii?Q?K97z4So07wZ+AJkFa6u2B+sfYWhCYMaPnenJ5dg/tY1lzyf71lD6kcTTRciC?=
 =?us-ascii?Q?E5V5+79lXhM8Z7Ef4Sr/pVuPJQwQRY6hyc1AcnfFhviK946tZ92+q3WPCt/E?=
 =?us-ascii?Q?oAufaKsctCz77loo6e5NbkShbxoi4N0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4985d4a0-9cab-4a55-7506-08da1ba4adfe
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 10:18:54.0004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cWYNEr7Efruq9snXhYatVBajbe9aBY7G3S08/IJvTGg/l0ic98CEUS9OAf216J2nOTvf/uER0zFp3WL1Ayp9zV7ez20yMy4d3XBPcgzBtTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5647
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_03:2022-04-11,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=945
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204110058
X-Proofpoint-ORIG-GUID: mdLgnrdShiFwbPvSF-T1dDN_1t7Lf3fw
X-Proofpoint-GUID: mdLgnrdShiFwbPvSF-T1dDN_1t7Lf3fw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 05:15:51PM +0200, Martin Kaiser wrote:
> ret is initialized to _SUCCESS, there's no need to set it again.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

I liked the original code better.  Otherwise you wonder, is it
intentional to return success on this path.  Smatch has a static
checker warning for these because most of the time it is a bug.
You can set "ret = _SUCCESS;" within 4 lines of the goto to silence
the warning.  A second, not as good option, is to add comment
"/* deliberatly returning success */" which saves a little time, but
also wastes a little time.

If you have to remove something, then remove the initializer.

The compiler is probably clever enough to remove these assignments so
it doesn't make sense to add an additional way to annotate success
paths.

regards,
dan carpenter



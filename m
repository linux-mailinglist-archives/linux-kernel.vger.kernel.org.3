Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879E252CBA5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 07:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbiESFvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 01:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiESFvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 01:51:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9A45C347
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 22:51:09 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IMIleZ005301;
        Thu, 19 May 2022 05:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=d7iXvOmH4JqOIxnnDIQcn5NY6PIxqJ2ZlbD5oxAllS0=;
 b=CIqj9kE28I9YPUbTUHAUgkPxZeSJ1+EAiSZgA90D96+4XtQIQvYVLRPChKMkFVuie/qW
 BlRdS/rboQ7pI94pkjeFlyjV3ZXdtPUblABMEgMsGlvKQdCvPzMmXMyNnXrEDj+kv5sP
 U9mGXVyMG1dm3xegY/+eiYtyBvztqWYJtWHwP4824kXl5fvFS89aCnzyJfX4kCsHt0Zk
 h2qp/TRaGpeam8MrJOi3yMCXftU7IMGonHWdhY4T8+yFwoINw/zPddQW9aYmdhsLukvc
 8TLVPtHcsdLQX2yTfKlgiisPcRxFQ07livsUNSWJUNaX+0n1ft5Xtlxfh+Nj5VnHdDG2 mw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g23723cf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 05:51:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24J5oqbA011102;
        Thu, 19 May 2022 05:51:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22vaex8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 05:51:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRMkWZyrt0TypQcoxmdmiumA/BRWWERcstEmqDMlLiJfLOp58wsUeyi1WdRmrBbw7TLVzvktL7wR23nznNLuLnGCRAEajuYVodwRcBKiwcXeMC0+h8dp5FjyGe8/9+ULEzVGw35ePFN7AjeM+wmHcTes1cg48mM8crHpvAg7BAKKyyAGsf8CEbPQ5e7SjLKPglT8YGWW3tw6+VqoZF2OsVcMYWW+PGr7ch77f5z1OWuWiwR0j36w1cipcjYJUFtz6dQZfY6kjuDWadQwjK+X3ynpEuUe/AaAciC7eE8xVTMruj6j6Y51xj+PDRfB/gsiDH+HkC2KsEvfF34W+O2vsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7iXvOmH4JqOIxnnDIQcn5NY6PIxqJ2ZlbD5oxAllS0=;
 b=ZL1PvHQwHL89WXbt+2YUC6LLDv/gExVmbJ5WxyP1MVwObuEXj8yjhuKw+Pb+QD555pguLyQLwHgxT5Qub8aPM4bi4veIGPa9UTk7CbwiP506aSsOhaik4oXJh/3C2oJlvxDFRAjG5A8Kvt+HhKv/XyWkK7JtQ+b+MOYaMI03GvR3iCYzRnYcs3WQON0wJunZ6y/L0+yTxdoiTaQOH63dWeOzh6Y9dLuUKgCCTP35/QD4flIMFJ0Yb/B/Fhw/Xqr9vTHgUzYKYK37PVJQV2mdkmqdvCSr10ubLLjH5DMLF1adYiEBi14CH6dbqYUEPyb+m+GF7qSYJ5YGWzLfsbgVGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7iXvOmH4JqOIxnnDIQcn5NY6PIxqJ2ZlbD5oxAllS0=;
 b=oAstG4m4bSoIcE+23TuQcq3QEjW6vtL++Z7y28VWDVORblonMTzjkTOybXxebLyNRZsCTsvh2Wq7i2jLMgHH49FjwEXZf3lTp7z4x+DVK27x91EQC8xl2CPRVPt76y9Y6Xqpi2bCgU8zrZbhfdb3WjjJ4A7KRfbCE2uMHaMr4cU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR1001MB2407.namprd10.prod.outlook.com
 (2603:10b6:910:47::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Thu, 19 May
 2022 05:49:58 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 05:49:57 +0000
Date:   Thu, 19 May 2022 08:49:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 1/4] staging: r8188eu: add error handling of rtw_read8
Message-ID: <20220519054938.GR29930@kadam>
References: <cover.1652911343.git.paskripkin@gmail.com>
 <1a9834b705054dcd0b0be0d929084c44a224abaa.1652911343.git.paskripkin@gmail.com>
 <20220519043306.GS4009@kadam>
 <ff322920-6ddd-159d-b2f2-c0e4fc2e518f@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff322920-6ddd-159d-b2f2-c0e4fc2e518f@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0058.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::6)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffc03978-6630-4c2f-9524-08da395b680b
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2407:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB24076C14A0BDCA64D1493D7A8ED09@CY4PR1001MB2407.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Il4t9/IOWPU/sLGKBxL0vcud7Jkg9W4xXliKmkrCGpWOigXiEo7wwR1t4y+1hbYnxr19YyJ+qs1P5GiEWjBGvmZvP4h83gekfe7RS9T/aVGIEA3/t1royx2FZAh+37+RgN+8TrId5NHQ1FGVw0ryZXkxkHYJ0NT+ZKiesds0Y126Uesft3IfuzTdzXkf1rjE98nmgmpNwGljdwVoNBqUDm/HdBfLosTInOWhlQLQa/SFRapZggwUmIb/H83s7MvWN+puopMAK8iD+Vcd2nTFhVBFWfg6ttVj75StP9n3FUsJWuqz94JSK7uKNq67jcPhabKnZJ7is5KOKuo4M2jP4trvQXfx9isUfg1b3GTjRZZXODfkWwu4QazckiM8FgOzPFMsk7Qz1Kb73sUskLi5MKvkoH2llyzmOP8o0Z2LZReWuw5ycFigO+RKjOBXA6rfVo97QKVZkiYSgIIIqeZdS5/5C3iYHjqEhYmc0NzJKPoDqZTdAj4LYYDYyqSve4HCD3MZSMYx5F+F4P/ftadevxUV/E8WMS6IrGLJidl5WetzoMQf0uCIKMNabZSSiIKub06eEjf16HQI429pNtJuvhL7VLXTnoYQnWjytI/hAcrrmQyoi2abRjuRRIaIO5TuZUrCkjeutIL+tgeGUTygX4IB2GoTfpHjOlFZMQYLRjGFS4oAGsgYz5lRpR8eO2v/tt73LS1+Lg91j6fmCRZ/TA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(316002)(44832011)(4326008)(8676002)(38100700002)(6666004)(2906002)(5660300002)(33716001)(6486002)(86362001)(66946007)(6506007)(6916009)(186003)(66476007)(83380400001)(6512007)(9686003)(508600001)(33656002)(8936002)(38350700002)(52116002)(66556008)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GrNYdRGrA1TU9DD3n770SZKgZI+e+i3C+l9v4m+ShE033X3/EKomLaw7Jb1X?=
 =?us-ascii?Q?eC3a/arCcvrhRzO7deCT4MBdFQEZh63oH2ChnRaFlmRiK8o762L2dq9V92Ps?=
 =?us-ascii?Q?OwHTx4wVDezKYLFQCLtIpON3j5XY6ns3crPqoNjPILQEYFnUOdjRqiEbgUvB?=
 =?us-ascii?Q?5ysPJNaxo9zvmgnaJSTtGpgEIpngL6pOq4LtZvxKu9utoKDz/djuOlXVKsen?=
 =?us-ascii?Q?BB4br2kQzw8z66NbcWiXYz0O8tBCX4U4DFrJrxmmpUZ3gR5IylUd5Lnz4ijP?=
 =?us-ascii?Q?ynT77C4u6KQyLex2apX5UCSEhtCrinNHsJ9F6nSzCGArD8Bd5mjXQr6x7RBx?=
 =?us-ascii?Q?mzMRHK4u7iNu/fFF5lb2KLy1wxJAZ3bwiZDLo1i3Ri2uReD3jMk0vF6OmWk6?=
 =?us-ascii?Q?ZwCP6Vk8fLLc2gQOM7O/AWChe0KsFfffmQlbRd9kAgNX+LDvMOORKjqdLIOp?=
 =?us-ascii?Q?twynbsyNAvu2XFV8px4cNLEw4RTRCWzQl6xJ4uE9F+hgJbjWx/52ofEP22Sg?=
 =?us-ascii?Q?XEYHFzDJhCePHlI37WkB9XrIE8sql+N4IK+P/asBYdGYy+5YK2BAQLD4HMI5?=
 =?us-ascii?Q?tUB15KUrnVzWehVQXZ+WE3Nfe6gPaas+clrLN+90Zlpxffyn3jdwLL8swA1B?=
 =?us-ascii?Q?YYNo0vdP/yJ4s1pBexb6c8lYIhuM24/uI6XAb9GQRMRZMjW5wiP5/ssCb/DH?=
 =?us-ascii?Q?vJrkgFVI/T7irs/MMXl9j9JHJXdKez1bhrY22+LSgWUwJPpW3qnyAdzDjFL3?=
 =?us-ascii?Q?hUe6sR2CWv96EU/vAzKw3ScWFtp9jeQjr+Lk7o63X/IritlIy7QP7AmJiQR8?=
 =?us-ascii?Q?X9Bm5ygj/Yixt0tZprXJdMkzidSYJAomXvDgQjGQKctfyy0G0/p3yKGPr9on?=
 =?us-ascii?Q?ZqG7ZBIE3MU6b2UFUbAORhPl9XDlXn//vBpg0cIs7cOPaI4K2vB42f+BGoM1?=
 =?us-ascii?Q?xPOpPfEoA4/bylXtJ/53eJWMZD3i5SycxJazMcrGKMPKhHixyvaicCyMkTZC?=
 =?us-ascii?Q?U6ZvKIHT3hRTeZYg+jBO1ok1WQvwhPdcnbM0OkIk6dK4iQh+GjIXWmOawzzd?=
 =?us-ascii?Q?E0LneKHlZxDcctdVLENhOUCBNYnf8tZobrccRoO8nMs0aNg4TBKAtO2LYEUW?=
 =?us-ascii?Q?/38us2GfrlfNqvu+gERUVPg9al2pZbL+XrOlMq5j/u8LqXFJeC76mNgKEWqp?=
 =?us-ascii?Q?DO1PRxt76QJJrPEm+mKTfWJmnZjTXA69cPYp4yvwZ5aJO0KXKwk05FQzdr8h?=
 =?us-ascii?Q?WibeWolNqLEiV4xwbU6EcwO4NYy82MargfvHRPA125VlFebC32/n2ho3NKtK?=
 =?us-ascii?Q?CFuGvYOyC9fiDJIvNF6KyDElTwHi0ojydZjxgTqxFXfTnl+KeyL1bZIM55rD?=
 =?us-ascii?Q?pal+xSNitEZvbgOZJq6c0tqOy5FxnBOasQxBnUV2ITpsDl/kFZvKECW4o3X/?=
 =?us-ascii?Q?+R0zcHpLrRrqr5YvxyRhsscXbSFP8bkcx1Z7aORtrZ0auiKkKSHzRkYBjntd?=
 =?us-ascii?Q?IgwSqkk73J36H8OerMBCuh0mhrsrint3UGpi/XLH5MhC4GPSrxXCCNda26ae?=
 =?us-ascii?Q?0/Y9hDwtKgZTsOYRlzz+AWTq+pzSKdmP87KtJE5ZHtYmY+CDXe5jF0GsI0bH?=
 =?us-ascii?Q?JyiUkuzdf/Qit4PciE5xjTdu8bpbSrlIm1QoQb8EdkJUFJrJVrZ4B3sSKPSg?=
 =?us-ascii?Q?qM4Ji23bqkIefL83BMzrToyQ6uiF6qBKpSAP6PnfJxaeVGJpPa4dUKOQZ6Pv?=
 =?us-ascii?Q?izHd5bttO/+sX6qiMnLtSdtVNvQ3Mx8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc03978-6630-4c2f-9524-08da395b680b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 05:49:57.7836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1gtHeflqfKfOh7tqSieyakuVlM/vz+bmMxa4s0T4LzxtETIrHfHaRBnTFU6tI8iCwdjN+6PCfc0j44RhmIugv0Sx8oSy3OPiun4eJiHmAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2407
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-18_09:2022-05-17,2022-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205190036
X-Proofpoint-GUID: 5olyTgP5fPx5N9cQuGeO8Pa1ERfuO9TY
X-Proofpoint-ORIG-GUID: 5olyTgP5fPx5N9cQuGeO8Pa1ERfuO9TY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 08:43:23AM +0300, Pavel Skripkin wrote:
> > > +
> > > +	if (reg & RAM_DL_SEL) { /* 8051 RAM code */
> > >  		rtw_write8(padapter, REG_MCUFWDL, 0x00);
> > >  		rtw_reset_8051(padapter);
> > >  	}
> > > @@ -278,7 +303,14 @@ int rtl8188e_firmware_download(struct adapter *padapter)
> > >  	fwdl_timeout = jiffies + msecs_to_jiffies(500);
> > >  	while (1) {
> > >  		/* reset the FWDL chksum */
> > > -		rtw_write8(padapter, REG_MCUFWDL, rtw_read8(padapter, REG_MCUFWDL) | FWDL_CHKSUM_RPT);
> > > +		res = rtw_read8(padapter, REG_MCUFWDL, &reg);
> > > +		if (res == -ENODEV)
> > > +			break;
> > > +
> > > +		if (res)
> > > +			continue;
> > 
> > This continue is wrong.  If res = -EPERM then it's a forever loop.
> > Let's just break for every error.
> > 
> 
> I was trying to avoid strict breaking the loop on any error, since I am
> afraid this might break the driver.
> 
> What about:
> 
> 	do {
> 		/* reset the FWDL chksum */
> 		ret = rtw_read8(padapter, REG_MCUFWDL, &reg);
> 		if (ret == -ENODEV || ret == -EPERM)
> 			break;
> 
> 		if (ret) {
> 			ret == _FAIL;
> 			continue;
> 		}
> 
> 		rtw_write8(padapter, REG_MCUFWDL, reg | FWDL_CHKSUM_RPT);
> 
> 		ret = write_fw(padapter, fw_data, fw_size);
> 	} while (!(ret == _SUCCESS ||
> 		    (time_after(jiffies, fwdl_timeout) && write_fw_retry++ >= 3)))
> 
> The idea is to break only on fatal errors to make things less strict
> 

This is too complicated.

Treat all the errors the same, and use one time out condition.  Either
based on the jiffies or the retry count.

regards,
dan carpenter


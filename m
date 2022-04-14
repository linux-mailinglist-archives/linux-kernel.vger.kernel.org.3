Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7BB50185D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbiDNQKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345680AbiDNQJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 12:09:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27F7105067
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:50:20 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EEsMJQ014133;
        Thu, 14 Apr 2022 15:50:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=RnYfvGgY3zxyUrdQEhzTkiXbx1v5NO2u5kdcjcMKH3o=;
 b=H3Ou6AbRn905YH0m9v+XMOllmfvqAiViWOHCqaw41K5u528XL924jRt3D9bueX3bF8GF
 uHXUS/T0HuUXr3gdlmJ5fTZWeCm9n8lMLGYFLMy9TugDrrGtG7ry6q9Qtfq057O/6v/2
 GNzDOZsjiBO9xecphmOXyL4Hengl8Yi4B6t+xen+hUnPiWBehEyOtZubd6QDBNYa3PJ9
 CEF6jVxj81oN99a33VnWiY0qVKb5X4UdB3J3leGcR09pVIBDciPao5UJnus+StYa1YI2
 kCfDfA5LR57+Nfu6htUeMMHbkN0tHf4QSNeVkm1oMDrXoo2tDuRapKl5z3MtFsFbvkky zA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb2pu5fcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 15:50:13 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23EFhNdR035992;
        Thu, 14 Apr 2022 15:50:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fck153eg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 15:50:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAUyPLAvzeKrOSXTSrIJVpNQeIc6x3rgQQBIF5c/+3mZCTwfwegMrgcO85oTD8TEZVdAqJAmC5W66FL3Wihsfe1IT4oXS2wEisxEf37qFP9GU4beOAALoiOOfBu8MKBaNWf15qhQdKJh+mkP49LB61oul9Le3h05KPqZPoddBDLvjNDEw7JINua0wieQ/GdgdAN2EBP0LNK9sodf3c5g/JMgmKaTh0suAyigdQn2zRwEV9kxXF7S5uu2YJirNqhM80R/fBUbD5GUiPFrira0jAB0dmNdqHcU5qSvdfZWcEg5VM6f8HuwVGMTMPB3HILSpX2qVMK1lWZbxbyFesXr5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnYfvGgY3zxyUrdQEhzTkiXbx1v5NO2u5kdcjcMKH3o=;
 b=F1bQO/JVRNMf6SWXahCCwt3YFWn1MoW6qIBSOIMblTOafOVsf52UcjeM3DySWMqIkM1y/Fg3BYC64I/vgBmZdEBi7VB+LZVjVxfT2llz4VESrEQNQNkTxKFrRlZMS67whWWL01vLfXrhVihecjTgSVU/5kuzYbHN4hJsdRQRkq/3LrJH0rvpfvlaahFw8tAKAJT9rNDWPqWW34JBjs0lxIyNbg7T0zTMXvHsC0o/ENBYaWHADMp8KhMOolT581h9bGfJ5WAozvA1wEQ70Z/Z9hoLS7SOJe1ER1JRyIXK7lDaw/KjkIj5ggiwb4/BaANhrFan27TkD2f/YYMdXnxkYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnYfvGgY3zxyUrdQEhzTkiXbx1v5NO2u5kdcjcMKH3o=;
 b=BeY1Ni9IflJfIw4UAqfy9dF1D73ZHyPnxjHvOvvH5JBLP3h7aqRx6wwyNpWJv5iS1+TOaG2bApSMq92d+AQFcrs4iZ0XXHssv3cjcD7iGT8v4VY2bZyxt3w3wnfDeL/bMgapHKBtvgn8/JoL7U0Swfe3KWdafGiEmTDdbeIQPHg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4472.namprd10.prod.outlook.com
 (2603:10b6:510:30::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 15:50:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Thu, 14 Apr 2022
 15:50:09 +0000
Date:   Thu, 14 Apr 2022 18:49:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wang Cheng <wanngchenng@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: fix uninit-value "data" and "mac"
Message-ID: <20220414154949.GM3293@kadam>
References: <20220414141223.qwiznrwgjyywngfg@ppc.localdomain>
 <20220414154215.GL3293@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414154215.GL3293@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0018.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93ba77a5-be32-49ed-c2c9-08da1e2e73d6
X-MS-TrafficTypeDiagnostic: PH0PR10MB4472:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB4472B50B0C98548DBBC74EA98EEF9@PH0PR10MB4472.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ajJgk86oyxPxa4Vpy7Z6iV/O2wSiK3AujH0hqMJca/0+zNwm8YsrjCUcDHquvJ7bqU/SeZSE1o9QfHSTjpwVHYd4DNrP8u98kQkwExXXi0ciM6i8HtE52FLJ+duDanKQZog8CaC4jU1ZlnbuyGrzx9rufmFjwdFevTYfqPAoFNYr9YL0UZK2UobwNrm1DugpNqaP3QOuhiUtAIqvZ6ugDxx1M+WD16FHid1ytEKZ6riC9P3bcyZ3yXIAJPZW0TYMe1p3yQWSwVxGTv3mFn5RIIO+2Q6DPNru4Oeb7Mln54Ymg/51TiFY4iuVqRHBBeMa/ikci3jTYkb/RG/Xe+RmQeXnmpJoVNE4yx24/LAv51xmwWO1B8vsf3rU9FqoqgKgyU7lRNev/n+JjUjj/IjdxZ0pwW+x9LxtHPvkMWTD1qkSVUoruCi15N9ZebSP0Pkcikt54JePDAXCWgS6e4S22OOECN6kVKT5lbVMIdINz9g/idXLQRSSYs585hvODKYSJp6cz8T6yZ/KxZdNaKV8mKHtmcmXK7fxw/PcMAaFwPJ/CfIgRrq0GSReQsTssY1Ui13sfqhFZ0rMl5g2vf6eFSVJ0ZabPHsP9u2IFwXk3kgXfLQVCDQaBZg4qzR7x0PLRQ9vMKCb/RyDt4UuQfrTX0SXjNlHNRGCDd45pT+SOqDd7n0+YKqLi7PvW68oAck94SD+lBDIjf4IDRLblpC5FfNVEXaFPqv5OgeA44FF+64=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6486002)(2906002)(5660300002)(8936002)(6666004)(508600001)(66556008)(8676002)(66476007)(6916009)(4326008)(316002)(86362001)(66946007)(38100700002)(44832011)(52116002)(83380400001)(186003)(33716001)(1076003)(6512007)(33656002)(26005)(6506007)(9686003)(38350700002)(334744004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pYweu9A7RQeM0l1CX/rFBl0kLaObr/uNIHMnPXLxPGK4SY8fb/d08Xpp7reT?=
 =?us-ascii?Q?e5DjJpQSf17EJMWLpsa2Lqajea3Rfmjac8qFU5cNZrs23118mX5upXq77dMX?=
 =?us-ascii?Q?8XsOJAsqKMxmnUXKqjw3ZlpUpoPN/x7mgT+rpPeRSQoTGzXCRF46GYDAcjwu?=
 =?us-ascii?Q?nkfOfR35TKv9rvvLvFgiRqHnY40FofsYYm0moMxbl8pPWK82CZqiWkal9nuw?=
 =?us-ascii?Q?nMt3nkRUiBVGvJV+xFVqdVv1uT9SLBqobXqp3cDdOqS+zv4s1VBDwefAYKEP?=
 =?us-ascii?Q?WeSDkzRrWU+GtUlt3DwDzFeLyjH6PBgAaJ8IIKn1fuFZ0fbCCesfX7bdwxJo?=
 =?us-ascii?Q?2GDRnlrFXJG+fd3Ux57umVADASkNk4QYaPD+guoQ5stTmXGa/MCKBBXpIww8?=
 =?us-ascii?Q?WTd3rbVTpefyOzcsFOHmVng/oqaxAru9sW4l0FaC1WUiSRi6LE07Y+xt3Mko?=
 =?us-ascii?Q?SEi7TgQJLcRYWpg490at1sVRYn9CX8LGWt7ThorgQVEi5Bs6VqmeWYmTS3IA?=
 =?us-ascii?Q?n9u9FlDVAuiN7QNuM2YQLv3PPGANcfaQ97Ja8NXTG5ZXzgUo5xsdSfazfO0i?=
 =?us-ascii?Q?n3ednK6++SE9WFIMV+qKtoNuPHNNNYMVFU6446Wbfejd9wzsI9WNIw5AExcg?=
 =?us-ascii?Q?u9FT4n016ev8TfMHMamUX1UJw2d5FCvNnwaRGw4hbwaK8cgP7TABooaG3buj?=
 =?us-ascii?Q?bSSk7u14sSYDx4lIMeur1z7sL26x8/gGkD072Tj/njJbfkXw0II0qDFsfWBz?=
 =?us-ascii?Q?o7O4cp9hIzEZfRkTnpWQAjY/cQl3s5308wh/vWY32zZm/V+sgaMynKhWQfIL?=
 =?us-ascii?Q?FvXEOEkSJqbIB2IICOG31b/AgCt1z9zDOqAkLmtPfOZsaiNSsAe/r+I00KKr?=
 =?us-ascii?Q?dbUL8fJv5qZwcUsstDt5DKVhN2ZsvNnmAL9BjWiDb/v6uZxiNOlAMcHLdXE+?=
 =?us-ascii?Q?9xbo95gsJq98SATlPFtPtAGEeIrDtO5VgaxXHMwIKyPnBm4gJVY+ZAV6NXTk?=
 =?us-ascii?Q?i8PQq3ZkDimiv2tM+BDVcFTMRePMjN3NBWRlZwEXQTiHNb3Fi2QqW1bLlczR?=
 =?us-ascii?Q?U2A5ROdKeT3WqFzceJetzNzFimme4Qb7b5blB3231U0mWchuIKf7aDmhNMcX?=
 =?us-ascii?Q?AvyGAOA6K3cVV8bAOo9E31M0sjjyAK4oTrwtGNGVN2TnBbUzdmWoFoI17LCs?=
 =?us-ascii?Q?CyO9B65TPMUxT3nWL0ZJjTu4aN30bwyff0TnVLjVChXphrWeItCaGiI51Qwr?=
 =?us-ascii?Q?gzzTs8KL9fljQPx8PynrGsAt8UUVklAseWo8xJeEumsoB7rbczX7lCvu58oi?=
 =?us-ascii?Q?8hDWr9ulshMoheWqllDGExap5asAgnMnY8WD0fFDuukLG4/rOpM2vxHo7Exb?=
 =?us-ascii?Q?5//DEjjHYAXvP+Yb+oSNrg4vSBOH2LnkY/IqUJtepIPceg/CtFlVnMYcvsGH?=
 =?us-ascii?Q?c5ryxzXi7W4WMAgug/kw0/aZQmlxtbhwox4QrYwyDe4pSyt6IJMh/SU3d1K8?=
 =?us-ascii?Q?WouT8F84BQzPpulIn16BJ2TSj+D0RdHXFylOMb5egU6OXb94oMd2HeJ25gyi?=
 =?us-ascii?Q?y93nJGFdENeHPQaXEA5NvDPChVjZR+l9luUTKmsgJfwzk8t3G5EL20X6evCW?=
 =?us-ascii?Q?bk/jX4OEQOjAmtFYYgcs5joR1EvfhrvCARU+6xo2dRHir9duC7qmzUrMRUIw?=
 =?us-ascii?Q?uKqrQT4UkHJ42hnt1u+4dZkq2l8EGvHraEh44iZawv1xKkblGmIdHRycVZkc?=
 =?us-ascii?Q?K50rKr6hTcs2v6VajNugPSP6jIQrtyA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ba77a5-be32-49ed-c2c9-08da1e2e73d6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 15:50:09.1973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdnS4D24kjHMkjL/JXowiHab0hnhcFrqM1cyThh3gCiCI6/zvPtWZDpkIJ7jNlSruqHdQT2+2CFp/Y2YfcjwVH0RmPwMP4pC/ZUG7L5owYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4472
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_04:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=826
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140084
X-Proofpoint-ORIG-GUID: qxAwvspfzjaGkQRFTZc4GoRor-0aheJx
X-Proofpoint-GUID: qxAwvspfzjaGkQRFTZc4GoRor-0aheJx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 06:42:15PM +0300, Dan Carpenter wrote:
> > diff --git a/drivers/staging/rtl8712/usb_ops_linux.c b/drivers/staging/rtl8712/usb_ops_linux.c
> > index f984a5ab2c6f..e321ca4453ca 100644
> > --- a/drivers/staging/rtl8712/usb_ops_linux.c
> > +++ b/drivers/staging/rtl8712/usb_ops_linux.c
> > @@ -495,12 +495,14 @@ int r8712_usbctrl_vendorreq(struct intf_priv *pintfpriv, u8 request, u16 value,
> >  	}
> >  	status = usb_control_msg(udev, pipe, request, reqtype, value, index,
> >  				 pIo_buf, len, 500);
> > -	if (status > 0) {  /* Success this control transfer. */
> > -		if (requesttype == 0x01) {
> > -			/* For Control read transfer, we have to copy the read
> > -			 * data from pIo_buf to pdata.
> > -			 */
> > -			memcpy(pdata, pIo_buf,  status);
> > +	/* For Control read transfer, copy the read data from pIo_buf to pdata
> > +	 * when control transfer success; otherwise init *pdata with 0.
> > +	 */
> > +	if (requesttype == 0x01) {
> > +		if (status > 0)
> > +			memcpy(pdata, pIo_buf, status);
> > +		else
> > +			*(u32 *)pdata = 0;
> >  		}
> 
> This isn't really correct.  In many cases status is "len" is less than 4.
> I'm slightly surprised that nothing complains about that as an
> uninitialized access.  But then another problem is that "status" can be
> less than "len".
> 
> A better fix instead of setting pdata to zero would be to add error
> checking in the callers and then change this code to use
> usb_control_msg_send/recv().  Probably just initialize "data" in the
> callers as well.

A different, less good option would be to, still add error handling in
the callers, but do:

	status = usb_control_msg();
	if (status < 0)
		goto free;
	if (status != len) {
		status = -EREMOTEIO;
		goto free;
	}
	if (requesttype == 0x01)
		memcpy(pdata, pIo_buf, status);

	status = 0;
free:
	kfree(palloc_buf);
	return status;

regards,
dan carpenter


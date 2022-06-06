Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BF653E849
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238278AbiFFNHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238236AbiFFNHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:07:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409E8D6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 06:07:08 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2569PRh9003664;
        Mon, 6 Jun 2022 13:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=GgUvU25WpTQsojfrvl4ZhuQNvODwpEJm48neXaCol7M=;
 b=kSua8pbEXLBL5VVWeLJsWufGesFtxAoAdQyaTGAqx18X9b1UmMtD+AInWfPTPsuOKX2E
 EP9ouxLb4eYQO9Sx/53dNvXWJfN5Nl6CLMHVQu5wCZsDsjhCziyPVObG1uEd2ouhgHZj
 EuXg3gKhC8gNNuXfeW8zZcRFxyJVFI+W2uqDZxI5cbYdM7cQ09EvPZgHdaP9H63+FnKM
 tVA52LBTEUWoTKhbKKEUWAqNu1OyRih/Pvbgt7J78QzuNrMJ+9BwsxZpJznpDDNSumC3
 gvl9ooHwFr9RFNBC6AYFrCEjpUHcgDhA4UW8Y6JGdQM4pr1ImRxar3I25qOBSVzIka3P 5Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ghexe8duc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 13:06:48 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256D0T2p036598;
        Mon, 6 Jun 2022 13:06:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu1ghv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 13:06:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlLMDof6XhP8LjDM7t77PiQ+EjzjGG6dAGcIR7Qe/r8jhAe+jeJSezak1d/MY79JXP7P7eJh7wFC3B1vEyucQafPEx6qG1JGD1QbUsT4Oei0hBptabTZM2q46Sn766E8xiaA48Av1Vt8QSMZGnO+lAHE/wv3qnmOucrDmddd0W2OlpX+jPbeuuukaqoXCJAIjJq1BUPzMUZhLIKLm05MMPKkQ1/KnypDDiThjBv/0AYp/3ExWeRJfGor4OHDPnxFKH3vmnvgF3bJbDZLF7DRhZgUWJ7MhhX/MRrgi5vCuf6vOMfCiXEGD9WF1YosBaOK9attOtKB+OmwWQk7Bn/avQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgUvU25WpTQsojfrvl4ZhuQNvODwpEJm48neXaCol7M=;
 b=Xs1gTGbF61jJkqHEWd2ZnC32H01uzyqQpAcoNeY2zc8MOEm+18DXyk0DdLFjFxFQpc4E4J61teI3/3kDg6amfe26S4nQkcNG+0v+DwVtlNSKTGSJtiuiRf9JAfr8XExnDopP4Y4w4d+/e+xsBJtMiXLPkVgaIAjn/nQJyjhSjQiG9mF+EM96c18w+9PnEfdMA1dBnnLHP+X0yTT56qXvHFTWpVBNE2F9QM6qkQjjIoMvNxIt+zLULitZiPA327JxFbYkH1PRrHA8kmSocLq7qxsv/BgJN3qYKd6rrbYgIyVNK0h3p0naOPgO64I5CWYZAjD8qjrW7b79EYJ0GUQi+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgUvU25WpTQsojfrvl4ZhuQNvODwpEJm48neXaCol7M=;
 b=tqERSY9GrjyxXcfdknFyk3AQlVX20azt13vXOkCcQi47OfjB1EAJpUR5qsDOk9QoMLYaqN8SwhvnmiBp7gIlEpcQA0Rrlfh38QKwtofvqLN9EXrHSKed16ZY0vwiU7YF9Swp/Tu/peaGa+25E8aIEH+iusGEfhZrs9F460CAaRA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BY5PR10MB4161.namprd10.prod.outlook.com
 (2603:10b6:a03:213::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Mon, 6 Jun
 2022 13:06:45 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 13:06:45 +0000
Date:   Mon, 6 Jun 2022 16:06:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jared Kangas <kangas.jd@gmail.com>
Cc:     vaibhav.sr@gmail.com, mgreer@animalcreek.com, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        johan@kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: greybus: audio: fix loop cursor use after
 iteration
Message-ID: <20220606130626.GX2146@kadam>
References: <20220605231806.720085-1-kangas.jd@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605231806.720085-1-kangas.jd@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0055.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::11)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c2acea5-ec06-4fef-5c87-08da47bd681d
X-MS-TrafficTypeDiagnostic: BY5PR10MB4161:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB4161CB36E9D032487E1E84718EA29@BY5PR10MB4161.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ZuLM5lBG8PukGvmcWcFZP6Q8PtV7FmdkIP25xGvtrP7eoVOZCNRl/tQPg20VEwICBFUyKUhhipC3UyFl9AyseyRVODWDYaXFzevnbxcbSl4yf7tI3B94s92IqOV0Lfc1tscUM16fwvnDflcEbBNXlgaSuF1YqtyIGZel3HiIFsa8s5d6uPUwodTQVCbPSQ2Q5BKUfpg5eVj71lZ2PYCIWrSh2up9VrJWVqmsE4RZRISDEZehbhQEaTANM6xGFjdww1GYjOKfoYo82fnWPrhbG1QBFPDU2/ENTHr6whS/h/BWyEpQtTBt5KGY9Mr88wowZ00KdSqh2MxDLZumh/cm20h4lEGJYc9rs5PQUcoosXxLF9Dw2eovrDH8pPWaVT7oKmvd/BysL22S3Wy7ckN7aApbykG1KZPd4zKGfmEyJAMZE6CDMoztL25Jbh9o7tPlMpfawMo747JnQR0h0CT4sxisjZEmAt6kyabl+uvYGIDOBUcr9RF+cIsoQZnKCqGb4LdR01IDxo258FpK7YApVSo6TPifRw+xz7BiImO5EfrDlmjIW49vqIblM4dIX6xhgzBSqZmwYzP04vfxy42i4LvYDckVmn1/W35d3SJqXt57MTyMaYr9USHH/ctE2QxKoEJ+TGz9Mjs3ZTli7Y1HpvAMeNFKBXGzrQ9IDt14MZ/xllFARsfVGqUgsNR87KncgUiHgyGjhvA4qREGOR1jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38100700002)(52116002)(6666004)(38350700002)(6916009)(83380400001)(44832011)(4744005)(6506007)(2906002)(86362001)(5660300002)(4326008)(33656002)(316002)(8676002)(33716001)(1076003)(508600001)(186003)(6486002)(66556008)(8936002)(66476007)(66946007)(26005)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SBUYx3MEpYc0orCOMmui1tOt7lGxEP2GYUQpJqKO3rt7jLy4Zh1B8Frl452k?=
 =?us-ascii?Q?y8BUBXY6VeENaGnaNp+1JHT1QyPI6xo5LFOFbmreLVRywFmZWo5/j+mlz90n?=
 =?us-ascii?Q?GGntMC9x+SGSjPqt2iU7DL5yXQ2z66QTLYz58qD8L1TFoqe661saTN/UvlOx?=
 =?us-ascii?Q?zYs0tN3VivuCvFfIoU/CWEzVTDe8IUaA/Y42RmHB4r22yZiAh8wC8YPmVOSS?=
 =?us-ascii?Q?Ki2KwGTp3Uw1ZNR8F9X/fzj2tDwR1hqK8j2dmmg3XrOw4sBRi0NrH+kOiIt/?=
 =?us-ascii?Q?4Hviw/jZm5Cv8x2cZ3qft4JHw5tni3/7HKEU+nuZFd92GU4rhg5+eCXT6DEN?=
 =?us-ascii?Q?XVU6o7pTxYYpmOjHZd7Yy/tw/VJlbXI3I6Tlv1Tt/jWkL6exAtnGac1mif+W?=
 =?us-ascii?Q?jgwx/UlwYpGN1dY5DjohZV6a6vI6D+aIAvWsPjBjDxqdZB2OI/sJom0AXpHQ?=
 =?us-ascii?Q?Iip7QI2DOrIQQMka8mfVXKCLFryLKSTyqKhnBeFCowPkgwBBf+DMXORZVRYy?=
 =?us-ascii?Q?S+nKTP1gACXtq4QZfgrmnFyYAKri/kyPHJcFlQqAXccM22+UBTj2bcaG2azK?=
 =?us-ascii?Q?Rt9Py9/Ua5HSRxeXKl/ZLxzTN2CDo/RKC8eNQiabaoNhl1CC4jFhoCQnzm2S?=
 =?us-ascii?Q?BJ70M6OWwM28VhvjyhKxfVadRnIgeK/eHgYGvG6/z759WjAqfIKFziWKMPb3?=
 =?us-ascii?Q?ctXvlk1ClGv/UhrfIohFaWjxeIjDHKP9K73zfGqykIJOGnW7+WEIzU0tAy3w?=
 =?us-ascii?Q?3nW7SEsK4H2TSYZA+Ts5hKmMOMImKzL8ap1D1335G3vDnMW3UcKgNNSCHAag?=
 =?us-ascii?Q?zxqkZQnXNoI2ZYDXTppZVbcd04+vOASYuEzp0Vn0JK6hnVEBRnvuCaZk8PvK?=
 =?us-ascii?Q?WABKL6KDeGCPIx4yy2PgzGMxfK9A3/jucLeEcXQIAPJFd8uTuypOKUAFlSLm?=
 =?us-ascii?Q?wXmmipPjoadnPOzwr2gB728HXsjV05CjqfIiWX/KFOqbJbMWBPLSiriECg50?=
 =?us-ascii?Q?22u0Od9dKimO4wBkQ3ONnrWPvtqKON6NXqjnedP/qfYaUbIj/4+67p49SsIn?=
 =?us-ascii?Q?OQsA50B79Z1TrRlN3oQyfHBi3Mb0hAiiRtOQLCCEnOaxhTTtg5rlDbkWP5dd?=
 =?us-ascii?Q?l2ODaNtgo1wmIuI4G+JYqp18BEoLg71opVnAvuWYlMmVru8IEpxquq9IMx7B?=
 =?us-ascii?Q?/UB1GErgwCFDmU7/YeTA8QJ5XA1C9+hR2WGPl1j6Cce+QbdZR/DUk3sJoPWw?=
 =?us-ascii?Q?tVAV0+k8SzRjeEOoweMgk1ju/TTcIXfJktLrtuxR2m6rxtdBr/FsQeJLDv2w?=
 =?us-ascii?Q?tUuvy45K2cIC6VdXoUZ2vaSxqtkreB3g+e+K91yi5pn0pr7qzDvPL095lgmc?=
 =?us-ascii?Q?hnrDbNA8uEfz7p6ugryrhynvRFXEXM3xDl1UwORBLEcRoY+o+feNv9B2odFf?=
 =?us-ascii?Q?ovWyktBNDMrdznz/fXSTusbdg27DyPTBsLnqhus5J/XKDVwraPTubppP1n7+?=
 =?us-ascii?Q?43MkyVCP5CoD7MfuO30uTeE5VCxX9vZh3DCK47Wizt/gQSsHyF9sxbZ1OQ4d?=
 =?us-ascii?Q?lqd8mIIHflgcVfGVFI/dkN+RX82eQzA3juFLEVLSxfHgm2Vr2ZnUUang4Ap+?=
 =?us-ascii?Q?eCzGL4W+ibbRnbdV10KeZ4FSaEn/GU4m4WHsJik0krSup2dX/Kd5iZTVnDy0?=
 =?us-ascii?Q?WemE5bhJKjYzlknimsv50i0JgbiqJfKwvKAN9tE9LPtp/Wm21WVJ2Zhj13Mq?=
 =?us-ascii?Q?WAaLI/d8OB1K3FUIKek/rgejFtgmGz0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2acea5-ec06-4fef-5c87-08da47bd681d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 13:06:45.1710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WGR7C+apgRf0rwbbMp+Kqr5y3v1lhPm6kANDhgxgGUEaIjx46bOV4uZcDitTOmLDh5ClggsjFD49LV38P5Lsr/mcc4KjJUkKaiOtTfbRFNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4161
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_04:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=744 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060060
X-Proofpoint-GUID: B05ZPBcFPjZmrChMFSF0a6OEIbUCL-YK
X-Proofpoint-ORIG-GUID: B05ZPBcFPjZmrChMFSF0a6OEIbUCL-YK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2022 at 04:18:06PM -0700, Jared Kangas wrote:
> gbaudio_dapm_free_controls() iterates over widgets using
> list_for_each_entry_safe(), which leaves the loop cursor pointing to a
> meaningless structure if it completes a traversal of the list. The
> cursor was set to NULL at the end of the loop body, but would be
> overwritten by the final loop cursor update.
> 
> Because of this behavior, the widget could be non-null after the loop
> even if the widget wasn't found, and the cleanup logic would treat the
> pointer as a valid widget to free.
> 
> To fix this, introduce a temporary variable to act as the loop cursor
> and copy it to a variable that can be accessed after the loop finishes.
> 
> This was detected with the help of Coccinelle.
> 

This needs a Fixes tag.

Fixes: 510e340efe0c ("staging: greybus: audio: Add helper APIs for dynamic audio modules")

Otherwise, looks good!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter


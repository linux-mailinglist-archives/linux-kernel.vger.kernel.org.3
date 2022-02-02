Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCFF4A6AEF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 05:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244410AbiBBEgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 23:36:09 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37214 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242010AbiBBEgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 23:36:08 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120ULgT005139;
        Wed, 2 Feb 2022 04:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=LvMb35MgKck5nXaBBV/tuI/EauNttrrxNedVfk3s+bk=;
 b=mycyVqmAH8rocMbJ7SXckz8+QA22r+iXSBhjekjocaitsDUUH1mmz3R0cdVehvovqwaL
 +s4OS7aCWJv5X+yWMnx46a7rfI2gEGoVZDmv6DCE9j5xXq6PCJl+Ag4lexejeAarB6xc
 33nzXUUVI4EyaAmYKPG9UY0Zie0f7L558CqKr4188+mfxYJjZep9FacDcliiL/CdCwFc
 dW2znrzWPKzzoCWpAFu2yNzrSr/6zp4w/gBswhXkalLUvQEH7L97KJwwcuQYtWXGa+qW
 1ejkuR3aYryFxoYCRrSTFnxrzETLpkNtk1S5RzczLkRJ7sUh9ocFOGvH/F4hvYswR5Dy ig== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjac4tr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 04:35:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2124Vj41104551;
        Wed, 2 Feb 2022 04:35:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by aserp3030.oracle.com with ESMTP id 3dvumgm0a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 04:35:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJGsGFWxHuvbocMuIaM+rA2YgiqDWFh/YrXW/gF3p+ExWeUZTS89ns7NH9aO5ETPr0zAZY35YiXobZH82YBrojjznh+nphnGpF6vfQqDVmwVlTxxPv1DzQ0gZ7Jd/Bm2CHyFw0jVwP9YMOu059O/PfDpmK0MyQ+1dpk2SfFHNrt0saj9b9YfinhFFPSRUZz9Wi78ftaM7S7YExK1KUAJfDGHAaWdKsuL/bae4yjrBVZL2s0K1/HMb6kGVB1aWTfCnP0WcMg8owhf2LwQnh336ZiwfrrPdqsRKokqC6HFUiMAutycmlt4kA/DZgsHYnubkWNDDMxXleY0NMooipML7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvMb35MgKck5nXaBBV/tuI/EauNttrrxNedVfk3s+bk=;
 b=SItH/usbKS5A64L2UqcDOxHrFu4ZYFONspi98QLP82pl8muSikQvexy6g6gQwR3kx9mhD8FPxvV3FpDMGh3ja93JOaHYxoJr3hAmefbMSVoYXvI7EKhgPIpz5x2hjC3fe0YKoNTjKgKpM22PsEDNK0QpmAdX7t/LbbPe2cQTPXzHBPrTeegWAXNnSbVPJPxyiGgeZLNntFmZ1Z1S5cb6M22PAbCLIOi6ZD7l44NsnNC7oFC7C5/c52r0sTlctzlDQfoB3dlLqLifXxPY9VP3ogHADoAg3k2ZMkKdscB06iwEne3qeWNhD6A0Ag4pI6xA0XLR/5DepYrOJVrhJ6c+lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvMb35MgKck5nXaBBV/tuI/EauNttrrxNedVfk3s+bk=;
 b=qCh20y50wjCdAgoE6H9os6H6e1ZpkPQdmIo1Gw9DQOG9qI6johZcDwNl6eWRxo0mbqHwAJdIjpCAEj3nnHjAQO8ixwLJEbPpjBs1E1KXd6sFNxtqd98JeXpFL4eaF4mtpnHiAG7xXcUwdWZTfaLUd7danRsbUE8FtVPohFWmpQk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM6PR10MB3882.namprd10.prod.outlook.com (2603:10b6:5:1d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Wed, 2 Feb
 2022 04:35:37 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1caa:b242:d255:65f3]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1caa:b242:d255:65f3%9]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 04:35:37 +0000
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com, colyli@suse.de
Subject: Re: [PATCHv2 6/7] block: add pi for nvme enhanced integrity
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq11r0l6gd7.fsf@ca-mkp.ca.oracle.com>
References: <20220201190128.3075065-1-kbusch@kernel.org>
        <20220201190128.3075065-7-kbusch@kernel.org>
Date:   Tue, 01 Feb 2022 23:35:35 -0500
In-Reply-To: <20220201190128.3075065-7-kbusch@kernel.org> (Keith Busch's
        message of "Tue, 1 Feb 2022 11:01:27 -0800")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0230.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::25) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce1f9f0d-afe5-4022-79eb-08d9e60575e2
X-MS-TrafficTypeDiagnostic: DM6PR10MB3882:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB38821609403E65E673A14B198E279@DM6PR10MB3882.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G4abHSiTKkqU1B3XYL0HZnSS57Rn8qzeux4By1dDFxMtheCJln2KF1l7Sd+OZ37q3mazUVBD4YoKx8hk4r7tArPj+VJE9TXfcAmPZaLA6gGPuJtQU508hD/rC/TzJOsAXF8wtXHgLbLY4cM2+iSdoHOUkZBszz54aQYEFhrndkaiTR+ecgCP+2SdASvRRzeGyaXs5ZjR5x7gbuFxCQI9qbD4/8HAbQ1oZscgT5Ey0OkBiDW8BJ6gKqaGpzYKJaJg9/JHPKHZth/MS28E0/ES1nRds5OVGgdmjWOit6MwmGFzKpK0q1s632BSCyXt4lT2cjCVkK5KhnyrLYuMpWZYofrFZ8R1Orl2Pf+qskPdXx1hec6oboSvwc21H4pMUfwPr/u30G4Efn79g4RlluKrFOIzu5+4ozTlxoaS6hXyCW2QolyB+fKLYNGq+9JG+oxwHlRC1/OOwWJy5Hpgpll4X3pgJu1gVl8OAOg8DjbuX2fYlwodS5f8DGOs6rJM6PO7PnPYLuyLpbuUkCYiUc85Qu1m90d3psbVjVJ/ODpmVUFOtPS6YgMe14RWXL1GIaHwEfpmyKZukTsu4wBychHr6RbpAwACTWPP/kpcqTssp0uwsMh6aVpGj5ITrCe495C5+GLS+r2A7CArlmHqvKIKhqoyE3nOO43lbO8tQ1I3votW27Yk742YG3X1cYx7ywAKWMMCqjgCIvWbTBDSsap8Uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(186003)(26005)(6486002)(508600001)(38100700002)(6506007)(86362001)(6512007)(52116002)(5660300002)(36916002)(83380400001)(316002)(66946007)(8676002)(4326008)(8936002)(66476007)(66556008)(6916009)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nxOP4jKeKVRmJ+6qXDLd9Vr3q8ixnQ9Ezkm0AEdyAAigXDzVJy43JkB9jBQC?=
 =?us-ascii?Q?0Gy03emkQU5jJP0CL/qn12r1TWlH/+4RmAR0gb661aRkmZ6bezfrW44q+N3k?=
 =?us-ascii?Q?byY9KSZMpf9mf65WUIOsaVL5u+hMyeDXCyadI9rOADriF9eyS/i734l1LBvq?=
 =?us-ascii?Q?oQt8e2WPsbG7BylJ5HkyaZbSUGs9nYkkvX1JnjBIPPyB6VckJW2SrmBmov7M?=
 =?us-ascii?Q?/Wb587Vwq7k7UxLu+ZF8FswEIU8EMHC8c+ZO2nWkL3nASVDpx0Oycwxlm8Af?=
 =?us-ascii?Q?aKca2tpy5+sqsDYyP9ILfak+fd9GLjrT0IvQJ5wzd5lsiXKGpPM1cKsTfOwS?=
 =?us-ascii?Q?+7Y1JEpeApf5b/J8dXtAr0plOWtuLscAW7sWjo8u52veRD/p7dFmCufvjLU3?=
 =?us-ascii?Q?4O8hWFkh0NpmkNRLeXjiwpWpMIG0rEy41vzCNNTN1OpK+z1CKM6RVYmWlMVo?=
 =?us-ascii?Q?Hs1s7/H5Ab/SpE+hJ3ztWkKS6fZrl5piR7hZFuIac1pMRvMw9nlp6ym1SPEm?=
 =?us-ascii?Q?76vDyjmi0E2z/NMXlQJWM4FMcKSg9kTlDBe6YWBvwDhF1Gbalpw9lkV8CVaJ?=
 =?us-ascii?Q?/vkC4KAaswpx9bk++OrhHL/DXwzxO8PrJGsBtRPZK9D/GJWMImG/R3wWENYj?=
 =?us-ascii?Q?SQfjRFgystPL0fnB6ftUOBVFBSvaQRqBLpKY247vXLDs5nzbaIORnG9HYW5f?=
 =?us-ascii?Q?MrVFYXfiWzuUuWoocnWV5YZYQA++Avh8es/4JMgmFRJ28jETZl8d/mXk5DLl?=
 =?us-ascii?Q?nijli8dlvdvGtBgGQA7Z64LNHQpHOeaerE5nfmp3di72R9Z6+nh4PAk+Qn0m?=
 =?us-ascii?Q?2eoMowVfTnZPA4tWs7N1/BoMbEr9LTbakjTe3WvDfjQQRCNYRarCi/RGrBJN?=
 =?us-ascii?Q?AeHJPPll1jPaaXbgW9nq62vq5CdWHSfKi2XWcAzIijRQH2Bfwsh3jzkJCE2o?=
 =?us-ascii?Q?bNQ84pQXjnZJ+4VPy0Q+AuKBz8TKK8QtLsQOynC8jH/DEWqTUru7LAOhyPMT?=
 =?us-ascii?Q?IoE6GxK2blMqPiRQ4aLP6G1b/ko63HdpO4goltGukTTMFgz0saR3AdvrEEDB?=
 =?us-ascii?Q?etrbENCIkL2KkXBxqYiHiZjhCw7b2ZJBspL3IukvDzVJjUNqpHdpxW2OcZqA?=
 =?us-ascii?Q?rX2d6Kqpf+RZhCJ/okx2h4+WtWzQL4ke7ss8gcSnrm/1DeSgyftWzNvA6NP3?=
 =?us-ascii?Q?btplzMUCHeeODGPwWvC5cHZf5k1REtIWvKC2936JYbTzvEN8KSQ6/QGLGf6G?=
 =?us-ascii?Q?0ph7n5Cgq+cRJ0f5m9dYim4Hg3s3cYMEETbMjewL7swN+1z8I+gIHofxZXIR?=
 =?us-ascii?Q?wapZQmyOZo2td3xIqWecsPM2K+eyHInXguHZPeSRV+L38EHd++Pw/tDuTKgf?=
 =?us-ascii?Q?uSRgYiHcsHICDy0xr5J4NuA2VBWypcTEUom9h5ixufXTnNuAxtj0ll3MBZs2?=
 =?us-ascii?Q?SQr9cvoOHmXYkwKsntGOaNuoiT/wQ3et0NwZFI8Mjb4cdOEzjOfLFryj2eMw?=
 =?us-ascii?Q?m7ZA/W5a27gpri6z4iAjGEJxYuRAaG/aLogtvUcNh1X246Gg6oage6e9+XUm?=
 =?us-ascii?Q?595rsqS5+MYdl3MCMJUlHX+RWu9dq91gSkFByPCTuamEYfFtc9DKHpzaQzu3?=
 =?us-ascii?Q?P5G+gMAEH082X+zhyDkr7dzrDAsRXWj16vbFIl4mJkugUR4vqsKJpGRkzhoq?=
 =?us-ascii?Q?qugQ9Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1f9f0d-afe5-4022-79eb-08d9e60575e2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 04:35:37.8200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNkTnpiHzs+30lRaVNOIOiIwNmtq3DVVvWGxEUhPzuAqWbOwbVnavrjj3sUKBGzf0632wmqWlxU9TBelIp1HmGGxu+oMs2+thePHGkpkPxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3882
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=894 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020020
X-Proofpoint-GUID: yQ-8ZMI2NV_JcW5fj8sfoy0LPbnGddGM
X-Proofpoint-ORIG-GUID: yQ-8ZMI2NV_JcW5fj8sfoy0LPbnGddGM
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Keith,

This all looks pretty good to me. Only nit I have is:

> +static blk_status_t nvme_pi_type1_verify_crc(struct blk_integrity_iter *iter)
> +{
> +	return nvme_crc64_verify(iter, T10_PI_TYPE1_PROTECTION);
> +}
> +
> +static blk_status_t nvme_pi_type1_generate_crc(struct blk_integrity_iter *iter)
> +{
> +	return nvme_crc64_generate(iter, T10_PI_TYPE1_PROTECTION);
> +}

Since we will definitely need to support the CRC32C variants, the
nvme_pi_type1_ prefix is a bit too generic. Wish we had gone with Type 4
and 5 like I originally proposed in SCSI. Not a big fan of this "almost
exactly like T10 Type 1 except for all these differences" situation that
NVMe ended up with.

Anyway. So I think the NVMe-specific format helpers need to at the very
least capture that they are for the CRC64 case.

Other than that it looks OK.

-- 
Martin K. Petersen	Oracle Linux Engineering

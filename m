Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D9250E1B3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242028AbiDYNdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242122AbiDYNbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:31:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4101140914;
        Mon, 25 Apr 2022 06:28:36 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PAEprN022522;
        Mon, 25 Apr 2022 13:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=sPCB9N4S8irY0nhp8Tlit7zgTAD3RnIQRb0sPz1U3y8=;
 b=eThLxeSn+sFbH7NGmUILy7mbU3K7m4B2BinRCPlc//02oX3r8ZqAQjMSPlMqHserYay/
 GS9vge2wu2K/eel/PyudZQzkIBdo8hY8CDGtdkU+87RASNFAGlddPxEznbWcxr1zu9fL
 gDiGkwyoHJU6t31hcF1XLPCXTFYMwyqzWHQryMvptRROqDZ4ePdgykWM50WaKaFqf+wP
 Ds5/8byjikAG3ZDBFgEIxvbWUlRmCpeJoP9w17ARag13MpZLpwzPOlBspAkN9RJvCByo
 vaFUpoYrGp/cK8aBWTVAS4jywjZuv6cNkmgqocKGZrTCY9OfDhYHY6XCHiY/ysBYc+t5 Xw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb0yu3h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 13:28:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23PDCUBH011156;
        Mon, 25 Apr 2022 13:28:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w1x9p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 13:28:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVcmlK8DXhjIPelJM05JDvQ6RaNqBxsuWUYkgXbuhwZgKOvr6oxiCNeBU0xb8GBnwaO9tCzM+ptx0EI6TuoMp6Z7g2ct81moFKR7QuLuu011AX4KbUAJ5OWbN6WZP8VouSgoh4B5NaNkc62cFBOFW26a6xmNCxkm0byqCbJhEidPTc+aVNu1Xx1m4UWPEyyJ/uqKPBT5ildOnHjAsCy3o4Sppcf4VHoIa/35zbWzbyF1IDsoXaVKmgeLUpcw4Pmy4thlxYnFjy46gw2FMdc5pk+qs12cmz3UV5DUSmfMD9+5kty317KZltDMxyi+Vp59WD3/mmveRDhwuseopH6p8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPCB9N4S8irY0nhp8Tlit7zgTAD3RnIQRb0sPz1U3y8=;
 b=WPE5Rg3cuJi3VkCvXWHdCWGDEYapjPIwCdxzRjdolQ5kwuEtzLxL7VeZle9u7COSy6vjYYrQqUUdRKTujPFdAQPhQhS8ookaJ2NSEnq/kOb2XZoc5neAb2C9IFUi8K0aRH+DCy/dG04UOd/Y+BCUjR2hAE4mJDu7mUEsTn/9FcTxlzx8HBorCFeqMxrSWhAAtLi3mbXXY/nkOu4idbi5LyWMV7uc20ZZenwEWyMoCkWs0sBEzY14Yo2KoUkOAjGxllLImDaM8W64C0WYX2Tuo6piwbpsu/ELmpR/JMBOhaYQy5MKZh9koQm2x17Buc2tFvv4qsOLLLzyi9noMmzXFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPCB9N4S8irY0nhp8Tlit7zgTAD3RnIQRb0sPz1U3y8=;
 b=gp66Li1ub5MoBxvpmm5wwRtOu9qrl/kUEEBnxqJ+4nlWN0PybRFzYawPtTjgjEI5ohb5JhKIG3jkCbaQoYNNrg1K1TUGE+ddGhn86TQ3Q6w/ZLPo8q1YjRmhuaPOu7pxmkb2KJFxzq7FR+Myb9z07Y3r6++mptqgqSas9DtEENA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB5566.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 13:28:14 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Mon, 25 Apr 2022
 13:28:14 +0000
Date:   Mon, 25 Apr 2022 16:27:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, zhenwei pi <pizhenwei@bytedance.com>,
        arei.gonglei@huawei.com, mst@redhat.com, jasowang@redhat.com
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        davem@davemloft.net, zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH v4 2/5] virtio-crypto: use private buffer for control
 request
Message-ID: <202204242344.JepUMdzP-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424104140.44841-3-pizhenwei@bytedance.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: CT2P275CA0044.ZAFP275.PROD.OUTLOOK.COM
 (2603:1086:100:a::32) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ea2bdaf-4e80-42b0-156d-08da26bf737b
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5566:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB55660085C84CEB6F5BAC79198EF89@SJ0PR10MB5566.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8PQBByoszYRzMOqZnR4XnzXAFDn7Gc1WyuI4xmFFLI8XBrDyzQAlgCQPou13HUe3yc46R+PUjUBX4/Y84c0eF3c3iezRTO1qJkOrIF9Pk2qpox4q0JwJ5cJz0PbFexYm4hXqcLRYpQ0TpG/+1mE0ZyBLJSkpa4mGiVcbKaA+ZXWBalJlm/6UnMdyrZ540J16oDreL94sU2psg7zreaQGMdVJpSaY5XlSHNj60UAZ/gfQWA+FCdoXbKy2be5LlkmVsxbJNql55H32yB/jCRc55zAwnvfMCt0n/tHHuKBO/A019fpcHRGriIADehX9PXm9J3iEDb8RyPxL5j4cdmX8WlStpiXQm9XDURSyasDfNsG9lDI2OIFmFAC2Z0qMrLlWQS2W2JoDGjP2lV8ZMU1eFS+MNl4vBNHZXD4r1msoLkNNLaAYIlKbPyiw7tQE4YB+UDPhxLMfgGYx9O9E6cBnpigrINtdfaMHH8I8Z16Vqsv3zrokWiEhmoJVTp3e3OzmRX2eF9BbcN/KNqt9lQWo+gTvglLVQdozjELaxDF53aVzzblmvpPg/0SF6f4+ZxkaL+y38t+t9lhwBNwLqs6RAnef7YDLXmJe+q5YvMExAA/dP/il5tOH1c25qebWnlG5RuirIKfVoSUtlL95m7Eh+m9p7klcEtjWoEpZsQXfM6yszC/kfFwHX+ugF9NFmf90s+3G39C6FVdbRZD5iO4TX8Mhvws2f21lZjQg5vklFHhC55dt5yf1dGTeKEbHfPZBkq/Lx7LMara8KKdl9acGc8j0zEwDWhxqQQDbqQjgh2NMqagLln3NuR193XMALFhzXA9Ao6jOvF4zQ9TT6iKhYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6666004)(26005)(508600001)(6486002)(38350700002)(6506007)(66556008)(30864003)(2906002)(44832011)(5660300002)(7416002)(36756003)(8936002)(38100700002)(66946007)(66476007)(8676002)(4326008)(52116002)(966005)(83380400001)(186003)(1076003)(9686003)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MxT17V0z0RDSLdv4OHngDSVbaylEpNCg9Bb29CcRvVjDRUma2tZTHYbY6OeL?=
 =?us-ascii?Q?1nQTCXmbvEYElMOm5zDJks+QHb4IhyaTzjRU0+5cOu/481n1qwHAzXFzlmiM?=
 =?us-ascii?Q?s1qUMyMqXr4CpKU99ZQdt121j4XTxVrHgT/DltXFMIFczw1GK2d0l4W4t02F?=
 =?us-ascii?Q?ycQV1o4WYjbSP+VMCzYTvFBEfNTZX9g8HGAb4yLzLOQArL9rB7QmvnPAtfE1?=
 =?us-ascii?Q?ZIlb+8x4YuLQSesh1IOQHlZTttXxQ2NzIT6hNzo0cSMxQkijkvydTagsaKQp?=
 =?us-ascii?Q?VuxypovQtfXS/hMoQzLH5uemrqMYw8wwCzOnJbS3p9OWp/U4RlmA0IVYBNhY?=
 =?us-ascii?Q?Q17AS0ywAnIctMvJyq4oRM2s5uiik0LYk55bvpLmKNP3CCjHtba+VAXDWUG5?=
 =?us-ascii?Q?26zAKaG93NTVYHyYqbzkXSDgbqW9Kq77kfpeD8ORPu1Nn+Ria522lE9CmsZz?=
 =?us-ascii?Q?6piogznViP7GxyMNBHZx9k/f6G5ZwvAdzEJ7aGW3268bPeWgBhNJcdc0sUy2?=
 =?us-ascii?Q?npT4Aesk2Gpxza9zOW6q+ufu6XShF65/u95SNJfe0FBt1JAbb4Xzl3XuRs5B?=
 =?us-ascii?Q?5xr8rhF5KNzrxMzUiyfxki2zW1R7swOxWhSUzQfKprJwkVXJSIpUBlwOW0c9?=
 =?us-ascii?Q?AVykATh1EdbqwIuntCCkwI6woTFrRJpRyYNVTFgvxhFbdsoqA5APwwynp1R/?=
 =?us-ascii?Q?iakpX8BlzRn5a0C3m/4R+ON4dfsIYB38F6iLNRigy0pTdQg3rnXlZxLlphZX?=
 =?us-ascii?Q?2gaZxda/ubok6dJbeiMPRE7WkaiGImvcVDjSJcHwUp0xwqF+USyaKRsSwfKC?=
 =?us-ascii?Q?KCgUUootT4IHzRtuZ34fXTS80Kw/WTQrQ3Q1kkMwwdMYAM9jvyAeHrL/7tVi?=
 =?us-ascii?Q?cOWf5QyjjvkIIV76ohL62UHnUcEE3v39VluLM7zhpcixAEa1DjDyIYKJADPN?=
 =?us-ascii?Q?nVAExyz+juiym26RM6JBrgCjBM+HZ6w1GRHU9RvVua8YG1Zy/2PXmJdCK2NZ?=
 =?us-ascii?Q?01OrHp6m04V5+T4bG3u/Cu3JtBIaNLCk1nzRPG5A2NKrdZzYBWnqduLnjpDM?=
 =?us-ascii?Q?pYW8h/+EgcR8XhE+2shJzuhKeGLDSt18m9Fzv3OEdswLt/6jzEznlqPQwSme?=
 =?us-ascii?Q?leTnvSLJneG2kbA+P3RREU9QAJaobdKpi8aHnfBgAmh4PUYfKODm0vXnT4nO?=
 =?us-ascii?Q?FTkPuyOQ7NGvx41b7EPDfAG3cbf77wONmSyrRqMXLCcN2cT0bCtgeevh/X03?=
 =?us-ascii?Q?E0yLiH9kjO9PMGDDioc18Nc2bCm9Ki1lL/VDSdG3UPeJEw0Xso3RI91xQ+mU?=
 =?us-ascii?Q?FY2/qCInfVKwh3XMef9nDW/svCFidTWfkdHyaKGjPazjXa1fDwKaFnC6tno3?=
 =?us-ascii?Q?+TK68yHrfcqnT6dbHdHu/ol4+efoMUYt+GgmtP65plpcani4bIymEKM04fQ5?=
 =?us-ascii?Q?mfbBf7hRCg1etEBlIp0sMVaQrd69aL+INtJod5VMo1I7uTC4Vs/UpCX3O6MI?=
 =?us-ascii?Q?0VnKGN/NjhMFz5dTQzPLS1jhW4WZV9xIsc8PYNpNMiss69NW8Hag+ZAGj2R9?=
 =?us-ascii?Q?Q4K8URPqrLEUr2Lp5br8wg05VUouVrga3o6F47VlDxk95aFw8vHEDjbNhnMh?=
 =?us-ascii?Q?wOvY+YZ9lWKqAjgQr6g1Flg7DIVTGYnZvK0PBqQy6S4rw7HEhaE+ljO06Vry?=
 =?us-ascii?Q?pWbzm0QVTM7LzNKr/Z06iBgtgeL9fnokysWjD0rVf2W4Vj1vERFJre9i09r6?=
 =?us-ascii?Q?wCUJ2/ZhmFkm1sGE7SZ1K1e3n6919iE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea2bdaf-4e80-42b0-156d-08da26bf737b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 13:28:14.5964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uu4Zy6fef3eNzJ1htm9AtC3G9G4Mt3c8erw9MXhg03lH+LAifCyE8vpWbe9OgEfFKsmkOOAzWrnrv5N7iJOP/ZLLPaFi732cIcfob6g+ryw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5566
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-25_06:2022-04-25,2022-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204250059
X-Proofpoint-ORIG-GUID: 4tqRdSSSkIrSlfeh5kztZFiR3emK2JEC
X-Proofpoint-GUID: 4tqRdSSSkIrSlfeh5kztZFiR3emK2JEC
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi zhenwei,

url:    https://github.com/intel-lab-lkp/linux/commits/zhenwei-pi/virtio-crypto-Improve-performance/20220424-184732
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220424/202204242344.JepUMdzP-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/crypto/virtio/virtio_crypto_akcipher_algs.c:165 virtio_crypto_alg_akcipher_init_session() error: potentially dereferencing uninitialized 'input'.
drivers/crypto/virtio/virtio_crypto_akcipher_algs.c:230 virtio_crypto_alg_akcipher_close_session() error: uninitialized symbol 'vc_ctrl_req'.
drivers/crypto/virtio/virtio_crypto_akcipher_algs.c:232 virtio_crypto_alg_akcipher_close_session() error: potentially dereferencing uninitialized 'ctrl_status'.
drivers/crypto/virtio/virtio_crypto_akcipher_algs.c:232 virtio_crypto_alg_akcipher_close_session() error: potentially dereferencing uninitialized 'destroy_session'.

vim +/input +165 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c

59ca6c93387d32 zhenwei pi 2022-03-02   99  static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher_ctx *ctx,
59ca6c93387d32 zhenwei pi 2022-03-02  100  		struct virtio_crypto_ctrl_header *header, void *para,
59ca6c93387d32 zhenwei pi 2022-03-02  101  		const uint8_t *key, unsigned int keylen)
59ca6c93387d32 zhenwei pi 2022-03-02  102  {
59ca6c93387d32 zhenwei pi 2022-03-02  103  	struct scatterlist outhdr_sg, key_sg, inhdr_sg, *sgs[3];
59ca6c93387d32 zhenwei pi 2022-03-02  104  	struct virtio_crypto *vcrypto = ctx->vcrypto;
59ca6c93387d32 zhenwei pi 2022-03-02  105  	uint8_t *pkey;
59ca6c93387d32 zhenwei pi 2022-03-02  106  	unsigned int inlen;
59ca6c93387d32 zhenwei pi 2022-03-02  107  	int err;
59ca6c93387d32 zhenwei pi 2022-03-02  108  	unsigned int num_out = 0, num_in = 0;
bb26cab9a7c25d zhenwei pi 2022-04-24  109  	struct virtio_crypto_op_ctrl_req *ctrl;
bb26cab9a7c25d zhenwei pi 2022-04-24  110  	struct virtio_crypto_session_input *input;
286da9ed04239c zhenwei pi 2022-04-24  111  	struct virtio_crypto_ctrl_request *vc_ctrl_req;
59ca6c93387d32 zhenwei pi 2022-03-02  112  
59ca6c93387d32 zhenwei pi 2022-03-02  113  	pkey = kmemdup(key, keylen, GFP_ATOMIC);
59ca6c93387d32 zhenwei pi 2022-03-02  114  	if (!pkey)
59ca6c93387d32 zhenwei pi 2022-03-02  115  		return -ENOMEM;
59ca6c93387d32 zhenwei pi 2022-03-02  116  
286da9ed04239c zhenwei pi 2022-04-24  117  	vc_ctrl_req = kzalloc(sizeof(*vc_ctrl_req), GFP_KERNEL);
286da9ed04239c zhenwei pi 2022-04-24  118  	if (!vc_ctrl_req) {
286da9ed04239c zhenwei pi 2022-04-24  119  		err = -ENOMEM;
286da9ed04239c zhenwei pi 2022-04-24  120  		goto out;
286da9ed04239c zhenwei pi 2022-04-24  121  	}
286da9ed04239c zhenwei pi 2022-04-24  122  
286da9ed04239c zhenwei pi 2022-04-24  123  	ctrl = &vc_ctrl_req->ctrl;
bb26cab9a7c25d zhenwei pi 2022-04-24  124  	memcpy(&ctrl->header, header, sizeof(ctrl->header));
bb26cab9a7c25d zhenwei pi 2022-04-24  125  	memcpy(&ctrl->u, para, sizeof(ctrl->u));
286da9ed04239c zhenwei pi 2022-04-24  126  	input = &vc_ctrl_req->input;
bb26cab9a7c25d zhenwei pi 2022-04-24  127  	input->status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
59ca6c93387d32 zhenwei pi 2022-03-02  128  
bb26cab9a7c25d zhenwei pi 2022-04-24  129  	sg_init_one(&outhdr_sg, ctrl, sizeof(*ctrl));
59ca6c93387d32 zhenwei pi 2022-03-02  130  	sgs[num_out++] = &outhdr_sg;
59ca6c93387d32 zhenwei pi 2022-03-02  131  
59ca6c93387d32 zhenwei pi 2022-03-02  132  	sg_init_one(&key_sg, pkey, keylen);
59ca6c93387d32 zhenwei pi 2022-03-02  133  	sgs[num_out++] = &key_sg;
59ca6c93387d32 zhenwei pi 2022-03-02  134  
bb26cab9a7c25d zhenwei pi 2022-04-24  135  	sg_init_one(&inhdr_sg, input, sizeof(*input));
59ca6c93387d32 zhenwei pi 2022-03-02  136  	sgs[num_out + num_in++] = &inhdr_sg;
59ca6c93387d32 zhenwei pi 2022-03-02  137  
286da9ed04239c zhenwei pi 2022-04-24  138  	spin_lock(&vcrypto->ctrl_lock);
59ca6c93387d32 zhenwei pi 2022-03-02  139  	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto, GFP_ATOMIC);
286da9ed04239c zhenwei pi 2022-04-24  140  	if (err < 0) {
286da9ed04239c zhenwei pi 2022-04-24  141  		spin_unlock(&vcrypto->ctrl_lock);
59ca6c93387d32 zhenwei pi 2022-03-02  142  		goto out;
286da9ed04239c zhenwei pi 2022-04-24  143  	}
59ca6c93387d32 zhenwei pi 2022-03-02  144  
59ca6c93387d32 zhenwei pi 2022-03-02  145  	virtqueue_kick(vcrypto->ctrl_vq);
59ca6c93387d32 zhenwei pi 2022-03-02  146  	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &inlen) &&
59ca6c93387d32 zhenwei pi 2022-03-02  147  	       !virtqueue_is_broken(vcrypto->ctrl_vq))
59ca6c93387d32 zhenwei pi 2022-03-02  148  		cpu_relax();
286da9ed04239c zhenwei pi 2022-04-24  149  	spin_unlock(&vcrypto->ctrl_lock);
59ca6c93387d32 zhenwei pi 2022-03-02  150  
bb26cab9a7c25d zhenwei pi 2022-04-24  151  	if (le32_to_cpu(input->status) != VIRTIO_CRYPTO_OK) {
59ca6c93387d32 zhenwei pi 2022-03-02  152  		err = -EINVAL;
59ca6c93387d32 zhenwei pi 2022-03-02  153  		goto out;
59ca6c93387d32 zhenwei pi 2022-03-02  154  	}
59ca6c93387d32 zhenwei pi 2022-03-02  155  
bb26cab9a7c25d zhenwei pi 2022-04-24  156  	ctx->session_id = le64_to_cpu(input->session_id);
59ca6c93387d32 zhenwei pi 2022-03-02  157  	ctx->session_valid = true;
59ca6c93387d32 zhenwei pi 2022-03-02  158  	err = 0;
59ca6c93387d32 zhenwei pi 2022-03-02  159  
59ca6c93387d32 zhenwei pi 2022-03-02  160  out:
286da9ed04239c zhenwei pi 2022-04-24  161  	kfree(vc_ctrl_req);
59ca6c93387d32 zhenwei pi 2022-03-02  162  	kfree_sensitive(pkey);
59ca6c93387d32 zhenwei pi 2022-03-02  163  
59ca6c93387d32 zhenwei pi 2022-03-02  164  	if (err < 0)
59ca6c93387d32 zhenwei pi 2022-03-02 @165  		pr_err("virtio_crypto: Create session failed status: %u\n",
bb26cab9a7c25d zhenwei pi 2022-04-24  166  			le32_to_cpu(input->status));

goto out is always suspicious.  "input" is not initialized.

59ca6c93387d32 zhenwei pi 2022-03-02  167  
59ca6c93387d32 zhenwei pi 2022-03-02  168  	return err;
59ca6c93387d32 zhenwei pi 2022-03-02  169  }
59ca6c93387d32 zhenwei pi 2022-03-02  170  
59ca6c93387d32 zhenwei pi 2022-03-02  171  static int virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akcipher_ctx *ctx)
59ca6c93387d32 zhenwei pi 2022-03-02  172  {
59ca6c93387d32 zhenwei pi 2022-03-02  173  	struct scatterlist outhdr_sg, inhdr_sg, *sgs[2];
59ca6c93387d32 zhenwei pi 2022-03-02  174  	struct virtio_crypto_destroy_session_req *destroy_session;
59ca6c93387d32 zhenwei pi 2022-03-02  175  	struct virtio_crypto *vcrypto = ctx->vcrypto;
59ca6c93387d32 zhenwei pi 2022-03-02  176  	unsigned int num_out = 0, num_in = 0, inlen;
59ca6c93387d32 zhenwei pi 2022-03-02  177  	int err;
bb26cab9a7c25d zhenwei pi 2022-04-24  178  	struct virtio_crypto_op_ctrl_req *ctrl;
bb26cab9a7c25d zhenwei pi 2022-04-24  179  	struct virtio_crypto_inhdr *ctrl_status;
286da9ed04239c zhenwei pi 2022-04-24  180  	struct virtio_crypto_ctrl_request *vc_ctrl_req;
59ca6c93387d32 zhenwei pi 2022-03-02  181  
59ca6c93387d32 zhenwei pi 2022-03-02  182  	if (!ctx->session_valid) {
59ca6c93387d32 zhenwei pi 2022-03-02  183  		err = 0;
59ca6c93387d32 zhenwei pi 2022-03-02  184  		goto out;
59ca6c93387d32 zhenwei pi 2022-03-02  185  	}
286da9ed04239c zhenwei pi 2022-04-24  186  
286da9ed04239c zhenwei pi 2022-04-24  187  	vc_ctrl_req = kzalloc(sizeof(*vc_ctrl_req), GFP_KERNEL);
286da9ed04239c zhenwei pi 2022-04-24  188  	if (!vc_ctrl_req) {
286da9ed04239c zhenwei pi 2022-04-24  189  		err = -ENOMEM;
286da9ed04239c zhenwei pi 2022-04-24  190  		goto out;
286da9ed04239c zhenwei pi 2022-04-24  191  	}
286da9ed04239c zhenwei pi 2022-04-24  192  
286da9ed04239c zhenwei pi 2022-04-24  193  	ctrl_status = &vc_ctrl_req->ctrl_status;
bb26cab9a7c25d zhenwei pi 2022-04-24  194  	ctrl_status->status = VIRTIO_CRYPTO_ERR;
286da9ed04239c zhenwei pi 2022-04-24  195  	ctrl = &vc_ctrl_req->ctrl;
bb26cab9a7c25d zhenwei pi 2022-04-24  196  	ctrl->header.opcode = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION);
bb26cab9a7c25d zhenwei pi 2022-04-24  197  	ctrl->header.queue_id = 0;
59ca6c93387d32 zhenwei pi 2022-03-02  198  
bb26cab9a7c25d zhenwei pi 2022-04-24  199  	destroy_session = &ctrl->u.destroy_session;
59ca6c93387d32 zhenwei pi 2022-03-02  200  	destroy_session->session_id = cpu_to_le64(ctx->session_id);
59ca6c93387d32 zhenwei pi 2022-03-02  201  
bb26cab9a7c25d zhenwei pi 2022-04-24  202  	sg_init_one(&outhdr_sg, ctrl, sizeof(*ctrl));
59ca6c93387d32 zhenwei pi 2022-03-02  203  	sgs[num_out++] = &outhdr_sg;
59ca6c93387d32 zhenwei pi 2022-03-02  204  
bb26cab9a7c25d zhenwei pi 2022-04-24  205  	sg_init_one(&inhdr_sg, &ctrl_status->status, sizeof(ctrl_status->status));
59ca6c93387d32 zhenwei pi 2022-03-02  206  	sgs[num_out + num_in++] = &inhdr_sg;
59ca6c93387d32 zhenwei pi 2022-03-02  207  
286da9ed04239c zhenwei pi 2022-04-24  208  	spin_lock(&vcrypto->ctrl_lock);
59ca6c93387d32 zhenwei pi 2022-03-02  209  	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto, GFP_ATOMIC);
286da9ed04239c zhenwei pi 2022-04-24  210  	if (err < 0) {
286da9ed04239c zhenwei pi 2022-04-24  211  		spin_unlock(&vcrypto->ctrl_lock);
59ca6c93387d32 zhenwei pi 2022-03-02  212  		goto out;
286da9ed04239c zhenwei pi 2022-04-24  213  	}
59ca6c93387d32 zhenwei pi 2022-03-02  214  
59ca6c93387d32 zhenwei pi 2022-03-02  215  	virtqueue_kick(vcrypto->ctrl_vq);
59ca6c93387d32 zhenwei pi 2022-03-02  216  	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &inlen) &&
59ca6c93387d32 zhenwei pi 2022-03-02  217  	       !virtqueue_is_broken(vcrypto->ctrl_vq))
59ca6c93387d32 zhenwei pi 2022-03-02  218  		cpu_relax();
286da9ed04239c zhenwei pi 2022-04-24  219  	spin_unlock(&vcrypto->ctrl_lock);
59ca6c93387d32 zhenwei pi 2022-03-02  220  
bb26cab9a7c25d zhenwei pi 2022-04-24  221  	if (ctrl_status->status != VIRTIO_CRYPTO_OK) {
59ca6c93387d32 zhenwei pi 2022-03-02  222  		err = -EINVAL;
59ca6c93387d32 zhenwei pi 2022-03-02  223  		goto out;
59ca6c93387d32 zhenwei pi 2022-03-02  224  	}
59ca6c93387d32 zhenwei pi 2022-03-02  225  
59ca6c93387d32 zhenwei pi 2022-03-02  226  	err = 0;
59ca6c93387d32 zhenwei pi 2022-03-02  227  	ctx->session_valid = false;
59ca6c93387d32 zhenwei pi 2022-03-02  228  
59ca6c93387d32 zhenwei pi 2022-03-02  229  out:
286da9ed04239c zhenwei pi 2022-04-24 @230  	kfree(vc_ctrl_req);
59ca6c93387d32 zhenwei pi 2022-03-02  231  	if (err < 0) {
59ca6c93387d32 zhenwei pi 2022-03-02 @232  		pr_err("virtio_crypto: Close session failed status: %u, session_id: 0x%llx\n",
bb26cab9a7c25d zhenwei pi 2022-04-24  233  			ctrl_status->status, destroy_session->session_id);

More canonical goto out bugs.

59ca6c93387d32 zhenwei pi 2022-03-02  234  	}
59ca6c93387d32 zhenwei pi 2022-03-02  235  
59ca6c93387d32 zhenwei pi 2022-03-02  236  	return err;
59ca6c93387d32 zhenwei pi 2022-03-02  237  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp


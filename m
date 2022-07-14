Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D50057423A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 06:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbiGNEWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 00:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbiGNEW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 00:22:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF94275FD;
        Wed, 13 Jul 2022 21:22:25 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26E3mxpZ020551;
        Thu, 14 Jul 2022 04:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=AlN9Hp9+KlkquTPFGxnks1+pPt0aRkDB5DYGzzm4jiU=;
 b=p0zPeU27Jc6IYtHMxRc7JY5EUenLxKOhMbYWucU9HvWwpAOsOr7Zfy8E+GnTCyLLNbOh
 058G5i7jePXTiXAog7mNARVk2idEsSpnftL9rVb5BQXhZwZMTRYQNFScLSZ0IAfzUfrn
 NT4sb6smbosEVjWVNjRVAaLpGkz4HRhi/OcvSV8ydPktGXUIQtPpD+SEgaCYIPj6Q/Zr
 fqztWyiQEsMk3oiT44IFVwfoKbdNuh1T7s37ewNH5aAyC/vbpTm09BgogCVLlYVdlhXw
 ZPWaPz5fvFJnifC43POPl7W5MSjlLqMVXBU6kor3YT2q+p2Uw4DStMUELmhB0z+qjWg3 sw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrkxs3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 04:22:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26E4Ax3Z001091;
        Thu, 14 Jul 2022 04:22:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7045au23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 04:22:14 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 26E4MD5D024736;
        Thu, 14 Jul 2022 04:22:13 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7045au20-1;
        Thu, 14 Jul 2022 04:22:13 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bean Huo <beanhuo@micron.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@yulong.com>
Subject: Re: [PATCH] scsi: ufs: ufshcd: Drop loglevel of WriteBoost message
Date:   Thu, 14 Jul 2022 00:22:08 -0400
Message-Id: <165777180152.4401.10494313651978409350.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220709000027.3929970-1-bjorn.andersson@linaro.org>
References: <20220709000027.3929970-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JIh9csJSE7p0J26esIo00Xrce3KvZAPV
X-Proofpoint-ORIG-GUID: JIh9csJSE7p0J26esIo00Xrce3KvZAPV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jul 2022 17:00:27 -0700, Bjorn Andersson wrote:

> Commit '3b5f3c0d0548 ("scsi: ufs: core: Tidy up WB configuration code")'
> changed the log level of the write boost enable/disable notification
> from debug to info, this results in a lot of noise in the kernel log
> during normal operation.
> 
> Drop it back to debug level to avoid this.
> 
> [...]

Applied to 5.19/scsi-fixes, thanks!

[1/1] scsi: ufs: ufshcd: Drop loglevel of WriteBoost message
      https://git.kernel.org/mkp/scsi/c/2ae57c995003

-- 
Martin K. Petersen	Oracle Linux Engineering

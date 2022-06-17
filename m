Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C018C54EF3C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 04:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379769AbiFQCWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 22:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379684AbiFQCVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 22:21:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D2864D0C;
        Thu, 16 Jun 2022 19:21:51 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25H0ZXnF005223;
        Fri, 17 Jun 2022 02:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=/IDfscGJbigkTQvOBIhJWEmer8zIUjgMWO9p5PQgSQA=;
 b=c+Hn4UMWKOScbRTcOFtwxKFgBLh2TVaTVZ+UpGSuOhFkF7ZgPT0yMXG9RKusN8dnxo/D
 2F9XadrPzyUSAxQQnk734c51g4ZsI2egC59UWlbNjvJVw71rTS49Uam5dhw9T6SEgVLD
 Gvw2EUHCoqiu6XV7qnpuNbYbTz7WAVtGjxzkJezINC2FECsk7QNBt+z0TxPWR9nu3yzX
 jTLNW/tyP1JGXEs94wIZ+dtdOyVb1VVAcklEr3duVu0VjP87Knb0L8sJpXMbmHzJc3WL
 wutrwGcILSIwxk7T7VcKSxq/+wzyUgFoovHI4YHUJXBZ7hIhnTnPVyE8WN5oATkkMFwO lg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjnscqr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 02:21:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25H2G6v8029102;
        Fri, 17 Jun 2022 02:21:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr27jd7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 02:21:41 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 25H2LejF040352;
        Fri, 17 Jun 2022 02:21:40 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr27jd7c-1;
        Fri, 17 Jun 2022 02:21:40 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-scsi@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        pankaj.dubey@samsung.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        chanho61.park@samsung.com, vkoul@kernel.org, avri.altman@wdc.com,
        bvanassche@acm.org
Subject: Re: [PATCH v4 0/6] Add support for UFS controller found in FSD SoC
Date:   Thu, 16 Jun 2022 22:21:34 -0400
Message-Id: <165543243408.26207.2708974889131816023.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220610104119.66401-1-alim.akhtar@samsung.com>
References: <CGME20220610104340epcas5p1d6cee31aba4dc2952ef09003c9e67863@epcas5p1.samsung.com> <20220610104119.66401-1-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fsCGy7F8DmoNCfScTqg5Z8WQ6kU3MqkU
X-Proofpoint-ORIG-GUID: fsCGy7F8DmoNCfScTqg5Z8WQ6kU3MqkU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jun 2022 16:11:13 +0530, Alim Akhtar wrote:

> This series adds support for UFS controller found in FSD SoC.
> The HCI is almost same as found on other Exynos SoCs with minor
> differences. This also adds the required UFS-PHY driver changes.
> 
> Patch 2/6: common change to handle different CDR offsets
> 
> *Changes since v3:
> - Addressed review comments on patch 6/6 from Chanho
> 
> [...]

Applied to 5.20/scsi-queue, thanks!

[4/6] dt-bindings: ufs: exynos-ufs: add fsd compatible
      https://git.kernel.org/mkp/scsi/c/ea83df8e3bd0
[5/6] ufs: host: ufs-exynos: add mphy apb clock mask
      https://git.kernel.org/mkp/scsi/c/daa782a51ec8
[6/6] ufs: host: ufs-exynos: add support for fsd ufs hci
      https://git.kernel.org/mkp/scsi/c/216f74e8059a

-- 
Martin K. Petersen	Oracle Linux Engineering

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D995423BC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbiFHFBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiFHFBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:01:03 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE2A2A142F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 18:37:25 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220608013723epoutp03b9fec689db875bb11dd8ae402085fce0~2gXLgz_4Q2574425744epoutp03M
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:37:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220608013723epoutp03b9fec689db875bb11dd8ae402085fce0~2gXLgz_4Q2574425744epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654652243;
        bh=opXGkGbRe/ErGUghcNtoq7K7Ws9fOuLrbwVHZpDOy3A=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=mLWgLsfLoiNhjQzY61FaaTwZyuv6dC2Xx0HAPMYNpJ3tTV1P7ISIq4ZylhqzLdBXN
         ZJ7KjdWD7W+/K2E40epmM9JuzGriMwO7XJyBjRNOB/QvsWrEcj3MO+HJhC8LB+oVZl
         YiHjpXmNvguVNPbi6UjpAC9KyU451HIqcZ5ys1h8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220608013722epcas2p39188b5686cb3b868a8688159d040bad4~2gXK74ALD2152521525epcas2p3E;
        Wed,  8 Jun 2022 01:37:22 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.98]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LHqbQ1KMgz4x9QP; Wed,  8 Jun
        2022 01:37:22 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.DC.10028.25DFF926; Wed,  8 Jun 2022 10:37:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220608013721epcas2p3a1505f7ade7ad2a41a3a8d477c5b0188~2gXJyNTDI0960809608epcas2p32;
        Wed,  8 Jun 2022 01:37:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220608013721epsmtrp1bac4215603a142cf7349c3a89c2028c7~2gXJxVmfh3218032180epsmtrp1A;
        Wed,  8 Jun 2022 01:37:21 +0000 (GMT)
X-AuditID: b6c32a47-573ff7000000272c-c0-629ffd522376
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.63.11276.15DFF926; Wed,  8 Jun 2022 10:37:21 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220608013721epsmtip272c4a5caf8d0c7d83dc3e875652ad4bb~2gXJlqiVm0080300803epsmtip2U;
        Wed,  8 Jun 2022 01:37:21 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Cc:     <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <avri.altman@wdc.com>, <bvanassche@acm.org>,
        <martin.petersen@oracle.com>, <pankaj.dubey@samsung.com>,
        "'Bharat Uppal'" <bharat.uppal@samsung.com>
In-Reply-To: <20220603154714.30532-3-alim.akhtar@samsung.com>
Subject: RE: [PATCH v2 2/7] phy: samsung-ufs: move cdr offset to drvdata
Date:   Wed, 8 Jun 2022 10:37:21 +0900
Message-ID: <002c01d87ad8$4c0f8600$e42e9200$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQFSBQ9Zoh1+pG8sApsbls4ebot9jgJwO85AAlq0dRmuK062cA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOJsWRmVeSWpSXmKPExsWy7bCmhW7Q3/lJBlf6OCwezNvGZvHy51U2
        i2svL7BbTPvwk9li/pFzrBZ9Lx4yW2x6fI3V4vKuOWwWE1Z9Y7Hovr6DzWL58X9MFou2fmG3
        aN17hN1i550TzA58HpeveHtsWtXJ5nHn2h42j81L6j0+Pr3F4tG3ZRWjx+dNch7tB7qZAjii
        sm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgM5WUihL
        zCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYF+gVJ+YWl+al6+WlllgZGhgYmQIVJmRn
        zHyykqVgMXPFr6YtzA2M15i6GDk5JARMJNaf+cDWxcjFISSwg1Gi//JiJgjnE6NEw4FXrBDO
        N0aJ7r637DAth9e/YAGxhQT2MkqcWSgCUfSCUWLdpsVgc9kE9CVedmwD6xYBmft5xScWEIdZ
        oJNJovvIBbAqTgFbiV+LJ7OB2MICHhLzrnQxdzFycLAIqEj0rwsGCfMKWEpsf7SSGcIWlDg5
        8wnYZmYBeYntb+cwQ1ykIPHz6TJWiLiIxOzONrC4iICTxIX3U6BqnnBInLhuCmG7SDxue8MG
        YQtLvDq+BeozKYmX/W1QdrHE0lmfwGEhIdDAKHF52y+oBmOJWc/aGUHuZBbQlFi/Sx/ElBBQ
        ljhyC+o0PomOw3/ZIcK8Eh1tQhCN6hIHtk9ngbBlJbrnfGadwKg0C8ljs5A8NgvJM7MQdi1g
        ZFnFKJZaUJybnlpsVGAMj+zk/NxNjOAUreW+g3HG2w96hxiZOBgPMUpwMCuJ8EqGz08S4k1J
        rKxKLcqPLyrNSS0+xGgKDOmJzFKiyfnALJFXEm9oYmlgYmZmaG5kamCuJM7rlbIhUUggPbEk
        NTs1tSC1CKaPiYNTqoGp31v2af3Tkqluej1TAx4cytTRlDp0cUtH5ffHwjkp8Wt+RIdrrTJK
        Otbj8Wbj9xnJ8pFXG7VWTV2jtdRzdtsN+bgjJUYXFSV+SOTGfTzjvlRyqvG1NI8P6l+v/fxw
        hSdNd9KMS8t/+uw9G1y385++Q+KZw1l6dren87if3Hkzd1N2z68GNhUFE9ktZ8VjhO5O0s/8
        t4G1R+L+vIgrS2Itcr06r1/jswydbOgYHLBVJ+am5SILJyteq5JbSslHOVQ3yD19qha5110m
        69JbX4M12sszvz/WZTlz2ir9hLawRL0gk9OTDWlZy27GqZVotP0LVzqrLvR9rkFESZ/S/c8H
        5Ptrfl9/emInw/Ee4XYlluKMREMt5qLiRAAvr9uPWgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsWy7bCSvG7g3/lJBsvfKlk8mLeNzeLlz6ts
        FtdeXmC3mPbhJ7PF/CPnWC36Xjxkttj0+BqrxeVdc9gsJqz6xmLRfX0Hm8Xy4/+YLBZt/cJu
        0br3CLvFzjsnmB34PC5f8fbYtKqTzePOtT1sHpuX1Ht8fHqLxaNvyypGj8+b5DzaD3QzBXBE
        cdmkpOZklqUW6dslcGXMfLKSpWAxc8Wvpi3MDYzXmLoYOTkkBEwkDq9/wdLFyMUhJLCbUWLv
        xmcsEAlZiWfvdrBD2MIS91uOsEIUPWOUWNP/nBEkwSagL/GyYxtYQkRgD6NE27xT7CAOs8Bk
        JolJDV+h5u5nlFi2ahNYC6eArcSvxZPZQGxhAQ+JeVe6mLsYOThYBFQk+tcFg4R5BSwltj9a
        yQxhC0qcnPkE7CRmAW2J3oetjBC2vMT2t3OYIc5TkPj5dBkrRFxEYnZnG1hcRMBJ4sL7KcwT
        GIVnIRk1C8moWUhGzULSvoCRZRWjZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnDMamnu
        YNy+6oPeIUYmDsZDjBIczEoivJLh85OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCe
        WJKanZpakFoEk2Xi4JRqYGrd+3zWrfysxQmNO8qFr7tdTpvuacL+K+2dovtLNb/r/0KehAuU
        XRPvX7CNRy+89+W0oz6BNyNXn1/+O/xf5vkjDsWG+qcaBVdxvX5zafo5m4qzeQmXr3iJ7NdV
        +pK0kdG9ce3xjOYLhiFckc+4bHs+cob2Tjy27J6IH19du3noO4a9P9x7leY0aM9ap/reqzZg
        arTR9u5fRvPttwu9mPiJ8W3Z9/kKO9WqQm6vcNEtzlVQWZxwucFO8PUal4fpWiFne3Y+P7R2
        0eWibVah3FWrdkx53G1Ws+BMc92JLVoyLHGrV0ufub6nOGXDzRU/aj/9fFa4wkp3qiFPs3HM
        dJ+NBnaTZbp4+XbpvjtwYqUSS3FGoqEWc1FxIgBuNA77SAMAAA==
X-CMS-MailID: 20220608013721epcas2p3a1505f7ade7ad2a41a3a8d477c5b0188
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220603154853epcas5p1f072d462edae5584d1cce601189ab85b
References: <20220603154714.30532-1-alim.akhtar@samsung.com>
        <CGME20220603154853epcas5p1f072d462edae5584d1cce601189ab85b@epcas5p1.samsung.com>
        <20220603154714.30532-3-alim.akhtar@samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH v2 2/7] phy: samsung-ufs: move cdr offset to drvdata
> 
> Move CDR lock offset to drv data so that it can be extended for other SoCs
> which are having CDR lock at different register offset.
> 
> Signed-off-by: Bharat Uppal <bharat.uppal@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>

Reviewed-by: Chanho Park <chanho61.park@samsung.com>

Best Regards,
Chanho Park


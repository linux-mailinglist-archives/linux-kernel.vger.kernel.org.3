Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE5958871D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbiHCGHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiHCGHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:07:47 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306791A3A5
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 23:07:46 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220803060740epoutp0113a6401a410013069567c31b51a9552b~HwLKHyBlo2868528685epoutp01L
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 06:07:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220803060740epoutp0113a6401a410013069567c31b51a9552b~HwLKHyBlo2868528685epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659506860;
        bh=+Oz6nq/1ommL7OELNnRSmq/iP9oPOc9dXHc/qJRwi+0=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=k7nMNAvF6GN9KG3Kxmz7TiJVsK86MRmHIH6biPmzv2HtWX97lC+BxhHLYzsOGMm0b
         GLLz8FJzV7gKUEeomLvkd0l8DfO1876IBnzMMlX7MtPq8vcV+6dioQ47nAJngUWG/y
         RtmcXgQ2D4GueOIkj5yAt3rxpPPeFDBC2iLy5OAo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220803060740epcas2p279a1b02f8c944b551211e4e26ede16e3~HwLJnxZOw1583415834epcas2p2-;
        Wed,  3 Aug 2022 06:07:40 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.101]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LyLxR4C9vz4x9Q7; Wed,  3 Aug
        2022 06:07:39 +0000 (GMT)
X-AuditID: b6c32a45-45bff700000025c2-97-62ea10ab9c00
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        CB.A8.09666.BA01AE26; Wed,  3 Aug 2022 15:07:39 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) (2) [PATCH v6 5/6] scsi: ufs: wb: Modify messages
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     Stanley Chu <chu.stanley@gmail.com>
CC:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CAGaU9a8Xxvtc0=Ci=ztwya=GqFZ0WB3p4wSo-QvLADdF3Fj+4Q@mail.gmail.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220803060739epcms2p4881142ec0b1c015612b8ccefa95cf819@epcms2p4>
Date:   Wed, 03 Aug 2022 15:07:39 +0900
X-CMS-MailID: 20220803060739epcms2p4881142ec0b1c015612b8ccefa95cf819
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmhe5qgVdJBlvOyFucfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBZfLu5ntnh5SNNi0Y1tTBaXd81hs+i+voPNYvnxf0wO3B6Xr3h7
        7Jx1l91j8Z6XTB4TFh1g9Pi+voPN4+PTWywefVtWMXp83iTn0X6gmymAMyrbJiM1MSW1SCE1
        Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoWCWFssScUqBQQGJxsZK+
        nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsb65a+ZCtaaV7yc
        uoSxgfGraRcjJ4eEgInExxVbmbsYuTiEBHYwSny8fIqpi5GDg1dAUOLvDmGQGmEBR4mzXcdZ
        QWwhASWJc2tmMYKUCAsYSNzqNQcJswnoSfxcMoMNxBYRUJc4svc4G8hIZoGzzBL/pnxhhdjF
        KzGj/SkLhC0tsX35VkYQm1MgUOJuy0WoGg2JH8t6mSFsUYmbq9+yw9jvj81nhLBFJFrvnYWq
        EZR48HM3VFxS4tChr2wgt0kI5EtsOBAIEa6ReLv8AFSJvsS1jo1gJ/AK+EpMf9QNFmcRUJX4
        smEx1CoXicn7XoH9wiygLbFs4WtmkJHMApoS63fpQ0xXljhyiwXmqYaNv9nR2cwCfBIdh//C
        xXfMe8IE0aomsajJaAKj8ixEKM9CsmoWwqoFjMyrGMVSC4pz01OLjQoM4RGbnJ+7iRGcZrVc
        dzBOfvtB7xAjEwfjIUYJDmYlEd47Ls+ThHhTEiurUovy44tKc1KLDzGaAj05kVlKNDkfmOjz
        SuINTSwNTMzMDM2NTA3MlcR5vVI2JAoJpCeWpGanphakFsH0MXFwSjUwTfv7S/DGlTunPuy9
        UXXiG8cHRcVnoj4FrOkibd9Tr5lVdH6KuVxukN6h+/hQiNk+JdXZKjZnOW38PNZr5No13Dk3
        ycfuzsJDzy6qPBRYKsGX17nv8Zp5UiU2616oFmrPmHLM8xXH5w1GJ1IfnXBj1/1W+2Pqhztr
        ONyDhHd9DpwabR5x77iHmbLN5Iva3AEntBW12P6Lmr5qOn17Ee/xkHnSTeLaGo33tPkY1NbN
        /mSzlzPaLi/y9s7Tn1eb5RhaxX+ICjrDeuPr5KPbbzK7XHL5fejg1peTS28WJLx43CKv1nx2
        xzx3cVmfcK791e9ffnzD+EI974Lhe6HGkm1N62ZpH5rRvPTXi5kPLQwWGyqxFGckGmoxFxUn
        AgB/bOLXPAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce
References: <CAGaU9a8Xxvtc0=Ci=ztwya=GqFZ0WB3p4wSo-QvLADdF3Fj+4Q@mail.gmail.com>
        <20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p2>
        <20220802080927epcms2p1d0d89c32a9bd07c07f233801bb954807@epcms2p1>
        <CAGaU9a_YZDxaeOCErnQwFF9mE7bARDf4sw3F3ai1DiWwNVMFcw@mail.gmail.com>
        <20220803041126epcms2p82bafb63e4f135d09017519ed3066f914@epcms2p8>
        <CGME20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p4>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>hi=C2=A0Jinyoung,=0D=0A>=0D=0A>On=C2=A0Wed,=C2=A0Aug=C2=A03,=C2=A02022=C2=
=A0at=C2=A012:11=C2=A0PM=C2=A0Jinyoung=C2=A0CHOI=C2=A0<j-young.choi=40samsu=
ng.com>=C2=A0wrote:=0D=0A>>=0D=0A>>=C2=A0Hi,=C2=A0Stanley,=0D=0A>>=0D=0A>>=
=C2=A0>Hi,=0D=0A>>=C2=A0>=0D=0A>>=C2=A0>On=C2=A0Tue,=C2=A0Aug=C2=A02,=C2=A0=
2022=C2=A0at=C2=A04:29=C2=A0PM=C2=A0Jinyoung=C2=A0CHOI=C2=A0<j-young.choi=
=40samsung.com>=C2=A0wrote:=0D=0A>>=C2=A0>>=0D=0A>>=C2=A0>>=C2=A0Messages=
=C2=A0are=C2=A0modified=C2=A0to=C2=A0fit=C2=A0the=C2=A0format=C2=A0of=C2=A0=
others.=0D=0A>>=C2=A0>>=0D=0A>>=C2=A0>>=C2=A0Reviewed-by:=C2=A0Avri=C2=A0Al=
tman=C2=A0<avri.altman=40wdc.com>=0D=0A>>=C2=A0>>=C2=A0Reviewed-by:=C2=A0Ba=
rt=C2=A0Van=C2=A0Assche=C2=A0<bvanassche=40acm.org>=0D=0A>>=C2=A0>>=C2=A0Si=
gned-off-by:=C2=A0Jinyoung=C2=A0Choi=C2=A0<j-young.choi=40samsung.com>=0D=
=0A>>=C2=A0>>=C2=A0---=0D=0A>>=C2=A0>>=C2=A0=C2=A0drivers/ufs/core/ufs-sysf=
s.c=C2=A0=7C=C2=A0=C2=A02=C2=A0+-=0D=0A>>=C2=A0>>=C2=A0=C2=A0drivers/ufs/co=
re/ufshcd.c=C2=A0=C2=A0=C2=A0=C2=A0=7C=C2=A023=C2=A0+++++++++++------------=
=0D=0A>>=C2=A0>>=C2=A0=C2=A02=C2=A0files=C2=A0changed,=C2=A012=C2=A0inserti=
ons(+),=C2=A013=C2=A0deletions(-)=0D=0A>>=C2=A0>>=0D=0A>>=C2=A0>>=C2=A0diff=
=C2=A0--git=C2=A0a/drivers/ufs/core/ufs-sysfs.c=C2=A0b/drivers/ufs/core/ufs=
-sysfs.c=0D=0A>>=C2=A0>>=C2=A0index=C2=A02c0b7f45de4b..117272cf7d61=C2=A010=
0644=0D=0A>>=C2=A0>>=C2=A0---=C2=A0a/drivers/ufs/core/ufs-sysfs.c=0D=0A>>=
=C2=A0>>=C2=A0+++=C2=A0b/drivers/ufs/core/ufs-sysfs.c=0D=0A>>=C2=A0>>=C2=A0=
=40=40=C2=A0-230,7=C2=A0+230,7=C2=A0=40=40=C2=A0static=C2=A0ssize_t=C2=A0wb=
_on_store(struct=C2=A0device=C2=A0*dev,=C2=A0struct=C2=A0device_attribute=
=C2=A0*attr,=0D=0A>>=C2=A0>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0If=C2=
=A0the=C2=A0platform=C2=A0supports=C2=A0UFSHCD_CAP_CLK_SCALING,=C2=A0turn=
=C2=A0WB=0D=0A>>=C2=A0>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0on/off=C2=
=A0will=C2=A0be=C2=A0done=C2=A0while=C2=A0clock=C2=A0scaling=C2=A0up/down.=
=0D=0A>>=C2=A0>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/=0D=0A>>=C2=A0>>=C2=A0=
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0dev_warn(dev,=C2=A0=22To=C2=A0control=C2=A0WB=C2=A0throug=
h=C2=A0wb_on=C2=A0is=C2=A0not=C2=A0allowed=21=5Cn=22);=0D=0A>>=C2=A0>>=C2=
=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0dev_warn(dev,=C2=A0=22It=C2=A0is=C2=A0not=C2=A0allowed=
=C2=A0to=C2=A0configure=C2=A0WB=21=5Cn=22);=0D=0A>>=C2=A0>>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0return=C2=A0-EOPNOTSUPP;=0D=0A>>=C2=A0>>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7D=0D=0A>>=C2=A0>>=0D=0A>>=C2=A0>>=C2=A0d=
iff=C2=A0--git=C2=A0a/drivers/ufs/core/ufshcd.c=C2=A0b/drivers/ufs/core/ufs=
hcd.c=0D=0A>>=C2=A0>>=C2=A0index=C2=A05099d161f115..dcd7f03db2a2=C2=A010064=
4=0D=0A>>=C2=A0>>=C2=A0---=C2=A0a/drivers/ufs/core/ufshcd.c=0D=0A>>=C2=A0>>=
=C2=A0+++=C2=A0b/drivers/ufs/core/ufshcd.c=0D=0A>>=C2=A0>>=C2=A0=40=40=C2=
=A0-5737,13=C2=A0+5737,13=C2=A0=40=40=C2=A0int=C2=A0ufshcd_wb_toggle(struct=
=C2=A0ufs_hba=C2=A0*hba,=C2=A0bool=C2=A0enable)=0D=0A>>=C2=A0>>=0D=0A>>=C2=
=A0>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret=C2=A0=3D=C2=
=A0__ufshcd_wb_toggle(hba,=C2=A0enable,=C2=A0QUERY_FLAG_IDN_WB_EN);=0D=0A>>=
=C2=A0>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(ret)=
=C2=A0=7B=0D=0A>>=C2=A0>>=C2=A0-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_err(hba->dev,=C2=A0=22%=
s=C2=A0Write=C2=A0Booster=C2=A0%s=C2=A0failed=C2=A0%d=5Cn=22,=0D=0A>>=C2=A0=
>>=C2=A0-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__f=
unc__,=C2=A0enable=C2=A0?=C2=A0=22enable=22=C2=A0:=C2=A0=22disable=22,=C2=
=A0ret);=0D=0A>>=C2=A0>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_err(hba->dev,=C2=A0=22%=
s:=C2=A0Write=C2=A0Booster=C2=A0%s=C2=A0failed=C2=A0%d=5Cn=22,=0D=0A>>=C2=
=A0>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
__func__,=C2=A0enable=C2=A0?=C2=A0=22enabling=22=C2=A0:=C2=A0=22disabling=
=22,=C2=A0ret);=0D=0A>>=C2=A0>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A0ret=
;=0D=0A>>=C2=A0>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7D=
=0D=0A>>=C2=A0>>=0D=0A>>=C2=A0>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0hba->dev_info.wb_enabled=C2=A0=3D=C2=A0enable;=0D=0A>>=C2=A0>>=
=C2=A0-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_info(hba->dev,=C2=A0=
=22%s=C2=A0Write=C2=A0Booster=C2=A0%s=5Cn=22,=0D=0A>>=C2=A0>>=C2=A0+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_info(hba->dev,=C2=A0=22%s:=C2=A0Wri=
te=C2=A0Booster=C2=A0%s=5Cn=22,=0D=0A>>=C2=A0>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__func__,=C2=A0enable=C2=A0=
?=C2=A0=22enabled=22=C2=A0:=C2=A0=22disabled=22);=0D=0A>>=C2=A0>=0D=0A>>=C2=
=A0>You=C2=A0need=C2=A0to=C2=A0rebase=C2=A0this=C2=A0patch=C2=A0to=C2=A0fol=
low=C2=A0the=C2=A0latest=C2=A0change=C2=A0as=0D=0A>>=C2=A0>https://lore.ker=
nel.org/all/20220709000027.3929970-1-bjorn.andersson=40linaro.org/=0D=0A>>=
=0D=0A>>=C2=A0I=C2=A0am=C2=A0currently=C2=A0working=C2=A0on=C2=A0the=C2=A0l=
atest=C2=A05.20/scsi-staging.=0D=0A>>=C2=A0In=C2=A0this=C2=A0case,=C2=A0can=
=C2=A0I=C2=A0refer=C2=A0the=C2=A0commit=C2=A0of=C2=A05.19/scsi-fixes=0D=0A>=
>=C2=A0and=C2=A0add=C2=A0commit=C2=A0to=C2=A05.20/scsi-staging?=0D=0A>>=C2=
=A0Or=C2=A0can=C2=A0I=C2=A0reflect=C2=A0it=C2=A0in=C2=A0my=C2=A0change?=0D=
=0A>>=C2=A0I=C2=A0have=C2=A0no=C2=A0experience,=C2=A0so=C2=A0please=C2=A0gu=
ide.=C2=A0:)=0D=0A>>=0D=0A>>=C2=A0Thank=C2=A0you=C2=A0for=C2=A0checking.=0D=
=0A>>=C2=A0Jinyoung.=0D=0A>>=0D=0A>>=0D=0A>=0D=0A>I=C2=A0did=C2=A0not=C2=A0=
notice=C2=A0that=C2=A0the=C2=A0below=C2=A0patch=C2=A0is=C2=A0merged=C2=A0to=
=C2=A05.19/scsi-fixes,=C2=A0so=0D=0A>I=C2=A0guess=C2=A0perhaps=C2=A0you=C2=
=A0could=C2=A0keep=C2=A0working=C2=A0on=C2=A0the=C2=A0latest=0D=0A>5.20/scs=
i-staging,=C2=A0and=C2=A0then=C2=A0Martin=C2=A0would=C2=A0help=C2=A0resolve=
=C2=A0the=C2=A0conflict.=0D=0A>https://lore.kernel.org/all/20220709000027.3=
929970-1-bjorn.andersson=40linaro.org/=0D=0A>=0D=0A>Thanks,=0D=0A>=0D=0A>St=
anley=0D=0A=0D=0AIt=20has=20been=20applied=20to=205.19/scsi-fixes,=0D=0Aso=
=20I=20will=20modify=20the=20debug=20level=20at=20my=20change=20for=20sync.=
=0D=0A=0D=0ABest=20Regards,=0D=0AJinyoung.

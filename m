Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F287583615
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 02:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbiG1AyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 20:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbiG1AyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 20:54:08 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE0851417
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 17:54:06 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220728005404epoutp01b4d38ede4b8ceced00d6d892317955fe~F2BohyCC00412204122epoutp01k
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 00:54:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220728005404epoutp01b4d38ede4b8ceced00d6d892317955fe~F2BohyCC00412204122epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658969644;
        bh=Pb3YgYxnaRhJurR/4mvMXEhRoIxVJf+CB0GvoTtvvDo=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=Gog5qVq4j4O6iW/6eKuzKkuawACVX42YuboJZsheKCYbXfBGH4dpZOgIOxJK0vyW5
         x3jZNYYGDS+f6ZDmshi8D9zYqvHs755DuPGWWHvP0yONugdgE7kZfzAkyyM7ziTCWx
         rsruIPi806auLq1zD+t1eDs7FC1CaN/yeFk5mdTY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220728005404epcas2p4735729f3667dabafa08f92f192e23261~F2BoF2SQ-1989819898epcas2p4S;
        Thu, 28 Jul 2022 00:54:04 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.88]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LtXGM4Pvwz4x9Q0; Thu, 28 Jul
        2022 00:54:03 +0000 (GMT)
X-AuditID: b6c32a48-9e1ff700000025be-eb-62e1de2bcdcf
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.8F.09662.B2ED1E26; Thu, 28 Jul 2022 09:54:03 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH v4 4/7] scsi: ufs: wb: Add explicit flush sysfs
 attribute
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     ALIM AKHTAR <alim.akhtar@samsung.com>,
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
In-Reply-To: <1f8e95da0c92f92937b5455a45430c939539d524.camel@gmail.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220728005403epcms2p35f6f6b0384aa05f44274445b52a89b68@epcms2p3>
Date:   Thu, 28 Jul 2022 09:54:03 +0900
X-CMS-MailID: 20220728005403epcms2p35f6f6b0384aa05f44274445b52a89b68
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmqa72vYdJBifmKVicfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBYvD2laLLqxjcni8q45bBbd13ewWSw//o/Jgcvj8hVvj8V7XjJ5
        TFh0gNHj+/oONo+PT2+xePRtWcXo8XmTnEf7gW6mAI6obJuM1MSU1CKF1Lzk/JTMvHRbJe/g
        eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBOVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
        JbZKqQUpOQXmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZM848Yi7oU6z4tjqxgXGBQhcjJ4eE
        gInE/bktLF2MXBxCAjsYJT6eOMjYxcjBwSsgKPF3hzBIjbBAkMTam7fZQWwhASWJc2tmgZUI
        CxhI3Oo1BwmzCehJ/Fwygw1kjIjAWWaJhQ+nMEHM55WY0f6UBcKWlti+fCsjiM0p4C7RcuY9
        O0RcQ+LHsl5mCFtU4ubqt+ww9vtj8xkhbBGJ1ntnoWoEJR783A0Vl5Q4dOgrG8g9EgL5EhsO
        BEKEayTeLj8AVaIvca1jI9gJvAK+Ejdv3QQbzyKgKrFl2g2oVS4ShxdOArOZBbQlli18zQwy
        kllAU2L9Ln2I6coSR26xwDzVsPE3OzqbWYBPouPwX7j4jnlPmCBa1SQWNRlBhGUkvh6ezz6B
        UWkWIpRnIVk7C2HtAkbmVYxiqQXFuempxUYFJvB4Tc7P3cQITqhaHjsYZ7/9oHeIkYmD8RCj
        BAezkghvQvT9JCHelMTKqtSi/Pii0pzU4kOMpkAPT2SWEk3OB6b0vJJ4QxNLAxMzM0NzI1MD
        cyVxXq+UDYlCAumJJanZqakFqUUwfUwcnFINTFuYmuYneYWcELKscLJYy/Qmuf7AI7Yvs50M
        timUCNRnNjNNz7d7063CuLO4dCfHb44piTkiYdGntjv/8QyXvtP73rHKcc69sszqV9y7LfsZ
        f69Ms3VcycSw72uenMfxHgdHEQXb5a38umc5HP67/8kJvl4mu2a5lMBibrWcpkjf2Kuyn8/k
        7teU9nR60Hf571qvSM+vDxmXlx3eKXt4wWypg8ebI1fMvl7lWWk5p0DL44NU0s9JjZ7Ov9+3
        hV3jzf9g1+nz8VAe/9zfyd0Wep5PLm94PjUjtkTfRPH+Jp2fkq4G73QaTsla7ty6tPNd98RT
        EhO9rpTwWLIJznigwb/333pz62ZmNa/Xq28osRRnJBpqMRcVJwIAbae53jEEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d
References: <1f8e95da0c92f92937b5455a45430c939539d524.camel@gmail.com>
        <20220727070724epcms2p8e449d0c89b52f03a9d3dc254df0ec547@epcms2p8>
        <20220727070410epcms2p5206785e4d960b32dcbb6729710dab535@epcms2p5>
        <20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p6>
        <20220727070841epcms2p5e212d617dd0f985555fa052f099013f0@epcms2p5>
        <CGME20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p3>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>=C2=A0There=C2=A0is=C2=A0the=C2=A0following=C2=A0quirk=C2=A0to=C2=A0bypas=
s=C2=A0=22WB=C2=A0Flush=22=C2=A0in=C2=A0Write=C2=A0Booster.=0D=0A>>=C2=A0=
=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0UFSHCI=
_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL=0D=0A>>=C2=A0=0D=0A>>=C2=A0If=C2=A0this=C2=
=A0quirk=C2=A0is=C2=A0not=C2=A0set,=C2=A0there=C2=A0is=C2=A0no=C2=A0knob=C2=
=A0that=C2=A0can=C2=A0control=C2=A0=22WB=0D=0A>>=C2=A0Flush=22.=0D=0A>=0D=
=0A>>=C2=A0=0D=0A>>=C2=A0There=C2=A0are=C2=A0three=C2=A0flags=C2=A0that=C2=
=A0control=C2=A0Write=C2=A0Booster=C2=A0Feature.=0D=0A>>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01.=C2=A0WB=C2=A0ON/OFF=0D=0A>>=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A02.=C2=A0WB=C2=A0Hibern=C2=A0Fl=
ush=C2=A0ON/OFF=C2=A0(implicitly)=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A03.=C2=A0WB=C2=A0Flush=C2=A0ON/OFF=C2=A0(explicit)=0D=
=0A>>=C2=A0=0D=0A>>=C2=A0The=C2=A0sysfs=C2=A0attribute=C2=A0that=C2=A0contr=
ols=C2=A0the=C2=A0WB=C2=A0was=C2=A0implemented.=C2=A0(1)=0D=0A>>=C2=A0=0D=
=0A>>=C2=A0In=C2=A0the=C2=A0case=C2=A0of=C2=A0=22Hibern=C2=A0Flush=22,=C2=
=A0it=C2=A0is=C2=A0always=C2=A0good=C2=A0to=C2=A0turn=C2=A0on.=0D=0A>>=C2=
=A0Control=C2=A0may=C2=A0not=C2=A0be=C2=A0required.=C2=A0(2)=0D=0A>>=C2=A0=
=0D=0A>>=C2=A0Finally,=C2=A0=22Flush=22=C2=A0may=C2=A0be=C2=A0necessary=C2=
=A0because=C2=A0the=C2=A0Auto-Hibern8=C2=A0is=C2=A0not=0D=0A>>=C2=A0support=
ed=C2=A0in=C2=A0a=C2=A0specific=C2=A0environment.=0D=0A>>=C2=A0So=C2=A0the=
=C2=A0sysfs=C2=A0attribute=C2=A0that=C2=A0controls=C2=A0this=C2=A0is=C2=A0n=
ecessary.=C2=A0(3)=0D=0A>>=C2=A0=0D=0A>>=C2=A0Reviewed-by:=C2=A0Avri=C2=A0A=
ltman=C2=A0<avri.altman=40wdc.com>=0D=0A>>=C2=A0Signed-off-by:=C2=A0Jinyoun=
g=C2=A0Choi=C2=A0<j-young.choi=40samsung.com>=0D=0A>>=C2=A0---=0D=0A>...=0D=
=0A>>=C2=A0=0D=0A>>=C2=A0+static=C2=A0ssize_t=C2=A0wb_buf_flush_en_store(st=
ruct=C2=A0device=C2=A0*dev,=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct=C2=A0device_attribute=C2=A0*attr,=
=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0const=C2=A0char=C2=A0*buf,=C2=A0size_t=C2=A0count)=0D=0A>>=C2=A0+=7B=
=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct=C2=A0ufs_hb=
a=C2=A0*hba=C2=A0=3D=C2=A0dev_get_drvdata(dev);=0D=0A>>=C2=A0+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned=C2=A0int=C2=A0wb_buf_flush_en;=0D=0A=
>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ssize_t=C2=A0res;=0D=0A>=
>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(u=
fshcd_is_wb_allowed(hba)=C2=A0&&=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=21(hba->quirks=C2=A0&=C2=A0UFSHCI_QUIRK_S=
KIP_MANUAL_WB_FLUSH_CTRL))=C2=A0=7B=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_warn(=
dev,=C2=A0=22It=C2=A0is=C2=A0not=C2=A0allowed=C2=A0to=C2=A0configure=C2=A0W=
B=C2=A0buf=0D=0A>>=C2=A0flush=21=5Cn=22);=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret=
urn=C2=A0-EOPNOTSUPP;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=7D=0D=0A>>=C2=A0+=0D=0A>Hi=C2=A0J-young,=0D=0A>=0D=0A>I=C2=A0don't=C2=
=A0understand=C2=A0here,=C2=A0if=C2=A0UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTR=
L=C2=A0is=0D=0A>not=C2=A0set=C2=A0(manual=C2=A0flush=C2=A0is=C2=A0not=C2=A0=
disable),=C2=A0so=C2=A0we=C2=A0cannot=C2=A0manually=C2=A0flush=0D=0A>buffer=
?=C2=A0or=C2=A0should=C2=A0we=C2=A0check=C2=A0if=C2=A0Auto-Hibern8=C2=A0is=
=C2=A0supported?=0D=0A>=0D=0A>Kind=C2=A0regards,=0D=0A>Bean=0D=0A=0D=0AHi=
=20Bean,=20=0D=0AAs=20the=20patch=20was=20separated,=20the=20conditional=20=
sentence=20went=20wrong.=0D=0AThank=20you=20for=20checking.=20I=20will=20mo=
dify=20it=20quickly.=0D=0A=0D=0AThanks,=0D=0AJinyoung.

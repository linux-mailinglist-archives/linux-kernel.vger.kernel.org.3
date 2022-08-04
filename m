Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEB7589624
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 04:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239156AbiHDCcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 22:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiHDCcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 22:32:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3D75FAC5;
        Wed,  3 Aug 2022 19:32:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6720B8227E;
        Thu,  4 Aug 2022 02:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B66C433B5;
        Thu,  4 Aug 2022 02:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659580333;
        bh=YDJGeoGJaH+aps1YMl40S0d5zjZuWvUVOXH7bdxfR4w=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=DfMByqkGVgftHeSYJjpPtSEZu7VyjZAkuGlLZL3Ja9igGRA1d76gVWZrFseAWH8vK
         zCpi+76mCxFOnSRdLNg+mPA6OopAA5KWdThEj8QPxIAyX8l25Ke6Ky9CXSlWdOPbBq
         Y4P087Z0sbKFzPn+j7Ca0t9MQiqK0RAP1lcAehExzPd3cIl5ciI8LUVTqw0lswUZRz
         tBRS/7ffyZD/6Yr6W77H+wLcpp5U30L9f398eDk9/HVAiTgjdBDhRFQ9Y9fDoq1eOH
         FFXzAFBIGO8ZfcSdNs0H1iF37j57m80ITU6kod072OKJ43pYF2RP7xRVVXwja/v4RN
         z33Da1rpRKn1A==
Received: by mail-vk1-f173.google.com with SMTP id x184so6729040vka.11;
        Wed, 03 Aug 2022 19:32:13 -0700 (PDT)
X-Gm-Message-State: AJIora+q23jbxi1bZUh4DBWJwUuzhPiQK2NfyyjBflJTx6WbnCFICYkK
        z018I2CMKuXg5OKfxGHe5SKdCBzv8A2sc02vmFY=
X-Google-Smtp-Source: AGRyM1u1k4KwmAXLl9ys/zYHnPBahO1X4x6oLGiy0Us7D2r6wRBA8etL1AuiKiecWpcdN3WLqG5LgHxID2Hopm2PAWw=
X-Received: by 2002:a05:6122:2212:b0:374:2fb5:19ef with SMTP id
 bb18-20020a056122221200b003742fb519efmr11147755vkb.2.1659580331926; Wed, 03
 Aug 2022 19:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220728062749.18701-1-zhiyong.tao@mediatek.com>
 <20220728062749.18701-2-zhiyong.tao@mediatek.com> <03a13ed4-e7cd-6f7d-f8f7-9b1e6193e202@linaro.org>
 <3d97d4c46467909739b8b69662412fe162dbe613.camel@mediatek.com>
In-Reply-To: <3d97d4c46467909739b8b69662412fe162dbe613.camel@mediatek.com>
Reply-To: wens@kernel.org
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Thu, 4 Aug 2022 10:31:59 +0800
X-Gmail-Original-Message-ID: <CAGb2v66eLF8WqQNWaAT-o3qQ=gvQTiq-UHryF6VuXVQG_VVD7Q@mail.gmail.com>
Message-ID: <CAGb2v66eLF8WqQNWaAT-o3qQ=gvQTiq-UHryF6VuXVQG_VVD7Q@mail.gmail.com>
Subject: Re: [PATCH v2] pmic: add mt6366 regulator document
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URI_NOVOWEL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Dropping individuals from CC list)

On Wed, Aug 3, 2022 at 6:14 PM Rex-BC Chen <rex-bc.chen@mediatek.com> wrote:
>
> On Thu, 2022-07-28 at 18:46 +0800, Krzysztof Kozlowski wrote:
> > On 28/07/2022 08:27, Zhiyong Tao wrote:
> > > From: zhiyong tao <zhiyong.tao@mediatek.com>
> > >
> > > Add mt6366 regulator document
> >
> > As usual with Mediatek your emails fail to properly pass modern SMTP
> > checks and you end up in spam.
> >
> > I reported it months ago to folks in Mediatek. No improvements since
> > that time.
> >
> > I stopped checking my spam folder for Mediatek stuff and all will be
> > ignored. I will also stop complaining about it - just ignore
> > Mediatek.
> >
> > Fix your systems, instead of putting additional effort on community
> > and
> > on reviewers.
> >
>
> Hello Krzysztof,
>
> I am Rex from MediaTek chrome project team.
> We noticed your complain of our upstream mail.
>
> First of all, sorry for the inconvenience.
> We really want to fix this SPAM issue.
>
> From our side, we can make sure mails for kernel upstream from MediaTek
> is clear and these mails pass the verification of DMARC/DKIM/SPF.
> Therefore, to identify the root cause, could you please provide us some
> mails that seen as SPAM from MediaTek?
> It's more useful if you can use the form of attachment. In that case,
> we can analyze whole mails including mail headers.
>
> We really appreciate your big support, and we hope we can fix this
> issue to reduce the inconvenience for reviewing series from MediaTek.
> If you can spare some time to help us for this, it would very helpful!!
>
> Our IT also adjust the DKIM setting today. If the situation of this
> issue it much better, please also let us know.

Tinghan's patch series [1] that was just sent out doesn't have DKIM headers.

As far as I know, people complaining about patches ending up in the spam
folder are mostly using Gmail. Gmail has gotten more strict about validating
emails. AFAIK it now requires either SPF or DKIM to pass, _and_ that the
passing result matches the sender domain.

That means SPF is out of the question for mailing lists. DKIM should work
if set up, but LAKML (and lists.infradead.org in general) mangles the
headers sometimes and would cause the signature check to fail. Other
mailing lists on vger.kernel.org or lists.linux.dev should fare better.

One can also "train" their Gmail instance to not land all of the emails
that fail validation in SPAM, but nevertheless some will end up there.

Attaching the full headers of [1] at the end.


Regards
ChenYu

[1] https://lore.kernel.org/linux-mediatek/20220804021553.14867-7-tinghan.shen@mediatek.com/


Received: by 2002:a59:c181:0:b0:2d5:960c:5e50 with SMTP id j1csp54837vqn;
        Wed, 3 Aug 2022 19:17:48 -0700 (PDT)
X-Google-Smtp-Source:
AGRyM1v5wlZ5UC+3Erd1R5AK8/4DKV9Dau0nK7xGWTXVGJhzseKMqEiK+ciebo9j7IKTo5raKO8P
X-Received: by 2002:a05:6830:43a0:b0:61c:c25b:eb88 with SMTP id
s32-20020a05683043a000b0061cc25beb88mr10429847otv.111.1659579468530;
        Wed, 03 Aug 2022 19:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659579468; cv=none;
        d=google.com; s=arc-20160816;
        b=0/a7sbxQvavDE6ZcJZ5sodj5S88yzB6m0VHx66EMPPfwV2MZTwi4nvoD/xkLEEezuZ
         +nkZvPXPHrB8XojB4+eCtw4zCCBzWhOO8yBqyQkUeVRu2EgguOCbKLouCw5rCHoEC9WJ
         3MtKbCIwV+TwRLfFze8lj8GKabDXhWAAnpfbB35kFevk+y8CsBIueXgFa+Lxbb/fPtyN
         ftu1maP4uUViYBHWx8w42KUAsSl2SQcuxJpwSaiK7dSFOt/IOIibpS/ruHCKy+YHPO95
         46Ecd0OZ1CGN+rZZS+FzfUi+8VbwYWZ7dKKFuppL93ErlozBuq4Nz2LT++CQarlHOpJ/
         MNbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
d=google.com; s=arc-20160816;
        h=errors-to:sender:content-transfer-encoding:list-subscribe:list-help
         :list-post:list-archive:list-unsubscribe:list-id:precedence
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:dkim-signature:dmarc-filter:delivered-to;
        bh=YugCKNbHuwbwo35Olh6mecj/5LgXHYwXhRiDSNx4g8I=;
        b=zxhhj5x9+HVTuqp6J76Uc0445tI6tASmU5alucBY762bYJrJQPjH5GHNGpPT241D6e
         yjFGRoAaMut74akROiHQMlhUEc1OYQSEcVCizruQgaRZupCAuzaWSJaTq2BLXicW9TFs
         oGzOA6k54Mh18yoiOr/A6MKh+4DG8M2QKi6SIhcOJY5eBmpgO+M+JixJKXnYMqZX9Y9f
         j8O4OW2evTjCtBpJ/pYEeKxZpWoAC+5WSnUhVuolhP4ZGjrUHFl4WTtMGwVEIdp2jCDb
         SI2nWrAagOc08AKfBfkoHDlmwgSz3FTg3C9ldzn/SXFh1ovNFmXN8FPecTd+1SQmp3US
         fRiw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@lists.infradead.org
header.s=bombadil.20210309 header.b="0rFqA//U";
       spf=pass (google.com: domain of
srs0=w7s4=yi=lists.infradead.org=linux-arm-kernel-bounces+wens=kernel.org@kernel.org
designates 139.178.84.217 as permitted sender)
smtp.mailfrom="SRS0=w7S4=YI=lists.infradead.org=linux-arm-kernel-bounces+wens=kernel.org@kernel.org";
       dmarc=fail (p=QUARANTINE sp=QUARANTINE dis=QUARANTINE)
header.from=mediatek.com
Return-Path: <SRS0=w7S4=YI=lists.infradead.org=linux-arm-kernel-bounces+wens=kernel.org@kernel.org>
Received: from dfw.source.kernel.org (dfw.source.kernel.org. [139.178.84.217])
        by mx.google.com with ESMTPS id
t130-20020aca5f88000000b00339fe268670si12938186oib.220.2022.08.03.19.17.48
        for <wens213@gmail.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Aug 2022 19:17:48 -0700 (PDT)
Received-SPF: pass (google.com: domain of
srs0=w7s4=yi=lists.infradead.org=linux-arm-kernel-bounces+wens=kernel.org@kernel.org
designates 139.178.84.217 as permitted sender)
client-ip=139.178.84.217;
Authentication-Results: mx.google.com;
       dkim=pass header.i=@lists.infradead.org
header.s=bombadil.20210309 header.b="0rFqA//U";
       spf=pass (google.com: domain of
srs0=w7s4=yi=lists.infradead.org=linux-arm-kernel-bounces+wens=kernel.org@kernel.org
designates 139.178.84.217 as permitted sender)
smtp.mailfrom="SRS0=w7S4=YI=lists.infradead.org=linux-arm-kernel-bounces+wens=kernel.org@kernel.org";
       dmarc=fail (p=QUARANTINE sp=QUARANTINE dis=QUARANTINE)
header.from=mediatek.com
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
(No client certificate requested) by dfw.source.kernel.org (Postfix)
with ESMTPS id 466CF61780 for <wens213@gmail.com>; Thu,
  4 Aug 2022 02:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) id BBAB0C433C1; Thu,
  4 Aug 2022 02:17:47 +0000 (UTC)
Delivered-To: wens@kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org
[198.137.202.133]) (using TLSv1.2 with cipher
ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits)) (No client certificate
requested) by smtp.kernel.org (Postfix) with ESMTPS id DD5F5C433D6 for
<wens@kernel.org>; Thu,
  4 Aug 2022 02:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.kernel.org DD5F5C433D6
Authentication-Results: smtp.kernel.org; dmarc=fail (p=quarantine
dis=none) header.from=mediatek.com
Authentication-Results: smtp.kernel.org; spf=none
smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
d=lists.infradead.org; s=bombadil.20210309; h=Sender:
Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
List-Owner; bh=YugCKNbHuwbwo35Olh6mecj/5LgXHYwXhRiDSNx4g8I=;
b=0rFqA//UuS3weT
eLvNzNB84/VT+8I87477CB14y0czmuPtKWmPxtP4p2TMcwTTk5AMwCmSgANdQ5RGz1eKBdxUR34Rb
IRRq0Aaeu8AAab139KLaLqXRIDzWDNAAa1GK9bbVRwPXTX0Ine+Yp6tubhWVv5VR+0c6yoqdOgpIq
UeznQpECXWMFv//X3y05jkNdsVZdrZO5ULjhZICKofEpjJWr1oo0Y/9AnL3EgFMT9AZ7jTgHQxRLl
nywXZwXjFwiM9cVfPlBihpB4T6bKpQyIPNkeb9CSv5m3FCD59FYkUr41gOcp9Z5yBpl705R5po0VR
yqI2dE35ZUbhTCjbEfTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org) by
bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux)) id
1oJQQ7-00DuEr-7h; Thu, 04 Aug 2022 02:17:07 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184]) by
bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux)) id
1oJQQ2-00Du8m-FY; Thu, 04 Aug 2022 02:17:04 +0000
X-UUID: 2fa656eda2a04d1ab7b69f85d53c4374-20220803
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:1d01f002-57e8-4399-98db-37702f2bfdb3,OB:0,LO
B:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
ION:release,TS:25
X-CID-META: VersionHash:0f94e32,CLOUDID:644b2cd1-841b-4e95-ad42-8f86e18f54fc,C
OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
,QS:nil,BEC:nil,COL:0
X-UUID: 2fa656eda2a04d1ab7b69f85d53c4374-20220803
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
mailgw01.mediatek.com (envelope-from <tinghan.shen@mediatek.com>)
(musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384
256/256) with ESMTP id 263722393; Wed, 03 Aug 2022 19:16:59 -0700
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
15.2.792.3; Thu, 4 Aug 2022 10:15:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
mtkcas11.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
15.0.1497.2 via Frontend Transport; Thu, 4 Aug 2022 10:15:55 +0800
From: Tinghan Shen <tinghan.shen@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
<krzysztof.kozlowski+dt@linaro.org>, Lee Jones <lee@kernel.org>,
Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com>, Tinghan Shen
<tinghan.shen@mediatek.com>, MandyJH Liu <mandyjh.liu@mediatek.com>
CC: <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
<linux-arm-kernel@lists.infradead.org>,
<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v5 06/20] dt-bindings: power: mediatek: Add bindings
for MediaTek SCPSYS
Date: Thu, 4 Aug 2022 10:15:39 +0800
Message-ID: <20220804021553.14867-7-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220804021553.14867-1-tinghan.shen@mediatek.com>
References: <20220804021553.14867-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3
X-CRM114-CacheID: sfid-20220803_191702_550657_36D1E4D2
X-CRM114-Status: GOOD (
  15.13
  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system
"bombadil.infradead.org", has NOT identified this incoming email as
spam.
  The original message has been attached to this so you can view it or
label similar future email.
  If you have any questions, see the administrator of that system for details.
  Content preview:
  The System Control Processor System (SCPSYS) has several power
    management related tasks in the system. Add the bindings for it.
Signed-off-by:
    Tinghan Shen <tinghan.shen@mediatek.com> Reviewed-by: Rob Herring
<robh@kernel.org>
    --- .../bindings/mfd/mediatek,mt8195-scpsys.yaml | 67 +++++++++++++++++++
    .../power/mediatek,power-co [...]
   Content analysis details:
   (-0.0 points, 5.0 required)
   pts rule name
              description ---- ----------------------
-------------------------------------------------- -0.0 SPF_PASS
               SPF: sender matches SPF record -0.0 SPF_HELO_PASS
          SPF: HELO matches SPF record
  0.0 UNPARSEABLE_RELAY
      Informational: message has unparseable relay
                             lines
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe:
<http://lists.infradead.org/mailman/options/linux-arm-kernel>,
<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe:
<http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+wens=kernel.org@lists.infradead.org



> Many thanks!!
>
> BRs,
> Rex
> >
> > >
> > > Signed-off-by: zhiyong tao <zhiyong.tao@mediatk.com>
> > > ---
> > >  .../regulator/mediatek,mt6366-regulator.yaml  | 375
> > > ++++++++++++++++++
> > >  1 file changed, 375 insertions(+)
> >
> > Subject does not match subsystem.
> >
> >
> > >  create mode 100755
> > > Documentation/devicetree/bindings/regulator/mediatek,mt6366-
> > > regulator.yaml
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/regulator/mediatek,mt6366-
> > > regulator.yaml
> > > b/Documentation/devicetree/bindings/regulator/mediatek,mt6366-
> > > regulator.yaml
> > > new file mode 100755
> > > index 000000000000..eb72c64757cf
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6366-
> > > regulator.yaml
> > > @@ -0,0 +1,375 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id:
> > > https://urldefense.com/v3/__http://devicetree.org/schemas/regulator/mediatek,mt6366-regulator.yaml*__;Iw!!CTRNKA9wMg0ARbw!3B-3NHQAsJc6ov022NnUIctYLEyx-BfxG5s85TBBvEfGjc4DdYDIqG_Ka_5D7scVo8CRtzLqokEX_thhM7XK_S90wg$
> > > +$schema:
> > > https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!3B-3NHQAsJc6ov022NnUIctYLEyx-BfxG5s85TBBvEfGjc4DdYDIqG_Ka_5D7scVo8CRtzLqokEX_thhM7Un6TPZdw$
> > > +
> > > +title: MT6366 Regulator from MediaTek Integrated
> > > +
> > > +maintainers:
> > > +  - Zhiyong Tao <zhiyong.tao@mediatek.com>
> > > +
> > > +description: |
> > > +  List of regulators provided by this controller. It is named
> > > +  according to its regulator type, buck_<name> and ldo_<name>.
> > > +  MT6366 regulators node should be sub node of the MT6397 MFD
> > > node.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: mediatek,mt6366-regulator
> > > +
> > > +  regulators:
> > > +    type: object
> > > +    description: List of regulators and its properties
> > > +
> > > +    patternProperties:
> > > +      "^buck-
> > > v(dram1|core|coresshub|proc11|proc12|gpu|s2|modem|s1)$":
> > > +        type: object
> > > +        $ref: "regulator.yaml#"
> >
> > No need for quotes.
> >
> > > +        unevaluatedProperties: false
> > > +
> > > +        properties:
> > > +          regulator-name:
> > > +            pattern:
> > > "^v(dram1|core|coresshub|proc11|proc12|gpu|s2|modem|s1)$"
> >
> > Why do you enforce specific regulator-name? Remove.
> >
> > > +
> > > +      "^ldo-v(dram2|sim1|ibr|rf12|usb|camio|camd|cn18|fe28)$":
> > > +        type: object
> > > +        $ref: "regulator.yaml#"
> > > +
> > > +        properties:
> > > +          regulator-name:
> > > +            pattern:
> > > "^v(dram2|sim1|ibr|rf12|usb|camio|camd|cn18|fe28)$"
> > > +
> > > +      "^ldo-v(xo22|efuse|mch|vcama1|emc|a12|vcama2|mc)$":
> > > +        type: object
> > > +        $ref: "regulator.yaml#"
> > > +
> > > +        properties:
> > > +          regulator-name:
> > > +            pattern:
> > > "^v(xo22|efuse|mch|vcama1|emc|a12|vcama2|mc)$"
> > > +
> > > +      "^buck-(vcore)-sshub$":
> > > +        type: object
> > > +        $ref: "regulator.yaml#"
> > > +        unevaluatedProperties: false
> > > +
> > > +        properties:
> > > +          regulator-name:
> > > +            pattern: "^vcore-sshub$"
> > > +
> > > +      "^ldo-vcn(28|33)-bt$":
> > > +        type: object
> > > +        $ref: "regulator.yaml#"
> > > +        unevaluatedProperties: false
> > > +
> > > +        properties:
> > > +          regulator-name:
> > > +            pattern: "^vcn(28|33)-bt$"
> > > +
> > > +      "^ldo-vcn(33)-wifi$":
> > > +        type: object
> > > +        $ref: "regulator.yaml#"
> > > +        unevaluatedProperties: false
> > > +
> > > +        properties:
> > > +          regulator-name:
> > > +            pattern: "^vcn33-wifi$"
> > > +
> > > +      "^ldo-vsram-(others)-sshub$":
> > > +        type: object
> > > +        $ref: "regulator.yaml#"
> > > +        unevaluatedProperties: false
> > > +
> > > +        properties:
> > > +          regulator-name:
> > > +            pattern: "^vsram-others-sshub$"
> > > +
> > > +      "^ldo-vsram-(proc11|others|gpu|proc12)$":
> > > +        type: object
> > > +        $ref: "regulator.yaml#"
> > > +        unevaluatedProperties: false
> > > +
> > > +        properties:
> > > +          regulator-name:
> > > +            pattern: "^vsram-(proc11|others|gpu|proc12)$"
> > > +
> > > +      "^ldo-v(aud|bif|io|ldo)28$":
> > > +        type: object
> > > +        $ref: "regulator.yaml#"
> > > +
> > > +        properties:
> > > +          regulator-name:
> > > +            pattern: "^v(aud|bif|io|ldo)28$"
> > > +
> > > +      "^ldo-v(io|aux|rf)18$":
> > > +        type: object
> > > +        $ref: "regulator.yaml#"
> > > +
> > > +        properties:
> > > +          regulator-name:
> > > +            pattern: "^v(io|aux|rf)18$"
> > > +
> > > +      "^ldo-vsim[2]$":
> > > +        type: object
> > > +        $ref: "regulator.yaml#"
> > > +
> > > +        properties:
> > > +          regulator-name:
> > > +            pattern: "^vsim2$"
> > > +
> > > +        required:
> > > +          - regulator-name
> > > +
> > > +required:
> > > +  - compatible
> > > +  - regulators
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    pmic {
> > > +      compatible = "mediatek,mt6366-regulator";
> > > +
> > > +      regulators {
> > > +        mt6366_vdram1_reg: buck-vdram1 {
> > > +            regulator-name = "vdram1";
> >
> > Messed up indentation. Use only one, so 4 space for DTS example.
> >
> >
> >
> > Best regards,
> > Krzysztof
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

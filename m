Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3309F510B7B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352418AbiDZVr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbiDZVr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:47:27 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B7A63BD4;
        Tue, 26 Apr 2022 14:44:17 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id i19so7009500eja.11;
        Tue, 26 Apr 2022 14:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=pwzD7uvJcpneBMqRia8zd6M2YJI38GAiQs6e8f6CTnY=;
        b=Gzgmj/cTOL+wV6eivxW23GBDDUM5Km5+QtqBDI0LV7Wh+rfnkJO5fcZchR6el7sOSn
         vJtVaPuWuly6NvY++u31aaGyWs6wTmX1pP2I9V7PcdsBTguLPEbWiaMATLQqeWPd0jGg
         0YsHgEFpYEZcJFDBIY+fBKBXN6U7Y9dKbt7iZa4QjFYxgI8GJZ6+nSPchJLigNkwCpls
         nXs8Jx5qDnVIl8Uzl9rFjhOUss4siMuDA3aI70FMQQtgv3v0cFnlw1kxeSBZOwwDf+BT
         jEY9jNhuaus4dYrsJxCKJqzKvtsH2GzIEdQzCdSud2/8alYzMHmb7bhUga4u87OawD6Z
         2lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=pwzD7uvJcpneBMqRia8zd6M2YJI38GAiQs6e8f6CTnY=;
        b=WVqDw2tUdcOpGj86XjdkqqCJ7didp+uDIHj68q2xYK2Mw0Z/27rlLdziLNyFhro6Lk
         X7VjX+OsykUwIfqTBWPfcDCbtC3wPQXIQrG6HtGNOH8cXQHht/KgT1KdiWd8+aqgfo/L
         09KPJJR+gcs4mjDpiFSQCj6DNKm6Sx/P4yO/MtMTqSFAsOlbZ2ABDwSDRuMJJ3SOdF0T
         T2nXpLo6iR1T8WxioYLb6g//XpNhluv8qP/RpZhc8v3oPn4OSxFb/+TKyVIF0tf6xv0C
         OkD1sMim1CZuz747M+b0b/wZTo1AuB7Tmc3Lym/uP9i5x7uTcCIH1vGyfrhl8LLAnVuI
         AwjA==
X-Gm-Message-State: AOAM53282s+aYPq0MZ3jC8A8DPNyM+tiMxBNkzHh15nsIrmOELItf3F1
        HIUMwQ0mXN1e2YBLCOeF39bOuE5rM2OQzg==
X-Google-Smtp-Source: ABdhPJwO8zwos76ZHGxqN5A1RElMVIp9PXo6e1gcf9Zr0xJCzirCe3ntX/HaNOvMBTFoVaPz/YhSIQ==
X-Received: by 2002:a17:906:c110:b0:6e0:dc2a:3393 with SMTP id do16-20020a170906c11000b006e0dc2a3393mr23494056ejc.512.1651009456359;
        Tue, 26 Apr 2022 14:44:16 -0700 (PDT)
Received: from [192.168.3.2] (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.googlemail.com with ESMTPSA id u4-20020a1709060b0400b006f391c5b37csm3243346ejg.82.2022.04.26.14.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 14:44:15 -0700 (PDT)
Message-ID: <8b45b572bc448460c0d0534a954e06bbd8ea90a9.camel@gmail.com>
Subject: Re: [PATCH v3 4/6] scsi: ufshpb: Change sysfs node hpb_stats/rb_*
 prefix to start with rcmd_*
From:   Bean Huo <huobean@gmail.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        "keosung.park@samsung.com" <keosung.park@samsung.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        "powen.kao@mediatek.com" <powen.kao@mediatek.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 26 Apr 2022 23:44:14 +0200
In-Reply-To: <DM6PR04MB657584CAA010AD7439A129D6FCF89@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220424220713.1253049-1-huobean@gmail.com>
         <20220424220713.1253049-5-huobean@gmail.com>
         <DM6PR04MB657584CAA010AD7439A129D6FCF89@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-25 at 06:19 +0000, Avri Altman wrote:
> > From: Bean Huo <beanhuo@micron.com>
> >=20
> > According to the documentation of the sysfs nodes rb_noti_cnt,
> > rb_active_cnt
> > and rb_inactive_cnt, they are all related to HPB recommendation in
> > UPIU
> > response packet. I don't know what 'rb' refers to, I think 'rcmd'
> > (recommendation) should be the correct abbreviation.
> rb stands for READ-BUFFER
>=20
Thanks. right. probably it is HPB READ BUFFER.  I think based on the
documentation,rcmd much makes sense, there is region inactive
recommendation, it is no need to issue HPB read buffer.

> >=20
> > Change the sysfs documentation about these sysfs nodes to highlight
> > what
> > they mean under different HPB control modes.
> >=20
> > Signed-off-by: Bean Huo <beanhuo@micron.com>
> I don't think it is allowed to change the kernel's ABI.
>=20

I don't know where this limitation is stated, I see a lot of ABI change
patches on the mailing list. Also, I didn't change its original
meaning, I added a new node meaning to make it clearer. According to
the documentation on these nodes, they should be used in HPB host
control mode, right? Otherwise, we should add a new note for HPB host
control mode. Considering we already have these nodes, we don't need to
change the HPB host control mode code just by changing the ABI to have
the HPB host control mode reuse them. Here are my thoughts on change.
Please consider my changes again.


Kind regards,
Bean


> Thanks,
> Avri


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB07587DFF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 16:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbiHBONg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 10:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237157AbiHBONd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 10:13:33 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2781B7A1;
        Tue,  2 Aug 2022 07:13:32 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id e15so12097515lfs.0;
        Tue, 02 Aug 2022 07:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=gq5EF+uHu6U2Mh2NO3P+IK3XirUR3qoeh2OQtRdPzSE=;
        b=Posz/xft7fE+5ODbToH8feXAc2vPzH4JAfErx4gip96rWFBD2vQgD0diCZS9MxC9dK
         nEX+UEpbPhrPn6rtebFwSre/DaMptZwarVun5mXyGT3XjkqTCwqpU54zRf7395f9seAl
         3qpxr0aemw4SAJnptCqzI+CUJmO2cmLs+YiH2YnO4YVh/v6oH4iTcmc1lSRKiiN0hU+/
         Djfy6yWMqcqPkEBQY2SylkuDOKsXE3jdfmDoXkW/0cL2SFNMnaX3hf7s2tcaFZq2Z8+P
         kjJNnmfRF9Cx8a98re5swBSrOBs38DIRGOzwLCUJZ9Qd9C9twGPNLvsItGRTT+LWCCVm
         xZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=gq5EF+uHu6U2Mh2NO3P+IK3XirUR3qoeh2OQtRdPzSE=;
        b=vSGMqTrN5httHXARyOAzdTZUIV+Z4zX5BXacQc7wKMdnPtxWfZ4hdSAK9wSr/0KPg3
         x1Fe/L/lDJdZV7cdQtVqbxpbiizYAxP57ltgupEXO+3w61IWY1kz6/SmHqgd2ZiBB0ve
         6PLgYxOXWPPmF4UAXEvWcEgPHs/b1zf+vXFmcIq1SMoJMsGqK5G4cnnyc8253P/NYJAU
         XgmznD9FGlVmaBrd0b9GSjew0nmpPbG8Nse6ehd3UCzGyByg6JP6Qzc9jDPTinrPb1bX
         0D9r5rsyrlVpc4eQJzl42iuebpY6OXwW6AKunXN4QGN2KxCjstb4vftYE/9DLibGHsKK
         FrhQ==
X-Gm-Message-State: ACgBeo0FDMN5ipha7rfUU6OrEiXkBpf9usEwuOneam5fdPGH1/xraDwl
        QJIUapwW3J2PgQOUg/E8WPK/cmt8e5eYmzEFrkzEGR//oPiF
X-Google-Smtp-Source: AA6agR6hwnxP5Z9bhzfcvqMV3gDZ5SCPC++b1OWUATEkGKBdN/dQZMHEWChjLXMb45tdDo/vVsY319c6vtdeCXd+2pg=
X-Received: by 2002:a05:6512:3096:b0:48b:4f7:9019 with SMTP id
 z22-20020a056512309600b0048b04f79019mr2133407lfd.208.1659449610460; Tue, 02
 Aug 2022 07:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p6>
 <20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p2> <20220802081039epcms2p68dbe18151e04103d10bf28751f9ace4e@epcms2p6>
In-Reply-To: <20220802081039epcms2p68dbe18151e04103d10bf28751f9ace4e@epcms2p6>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Tue, 2 Aug 2022 22:13:18 +0800
Message-ID: <CAGaU9a9jwjd8NW8M7Cju440nqpHDfuY0m7FWM8dx++m8R=ZYgA@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] scsi: ufs: wb: Move the comment to the right position
To:     j-young.choi@samsung.com
Cc:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 4:27 PM Jinyoung CHOI <j-young.choi@samsung.com> wrote:
>
> The location of the comment is wrong. so fix it.
>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5085AB8E3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 21:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiIBTcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 15:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiIBTcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 15:32:43 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7EE106D95
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 12:32:42 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id u22so2751235plq.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 12:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=V7R5ZOzee+xNnoboOxnimiekBXFaPMkt2x1jVom81wY=;
        b=UdNWXvmdkjm7IwgxaKgRblvRTaFdSOEqqdCPPbdnMeyKoxR9Tuw+ILuoXPizs5yUAF
         ojFKUICsre1zYdyHYkwN7Rp4zW8yUjKjJETfzHxV4vzMBHlhnEHcyr8wcAdMhSPgXJ0+
         SuoVs/NActrqAuzWw5oECGdJcfYrw179QgV9MVTX5RtN+F6oXywXQ0DWuQZXqzpDziN8
         JGHEcJSUAe2se2ZSc+l00bQXKhhwbvOnKsRMxWXUMwg4+z+8qeYTowuFoIpO8cygjt5X
         efxVatVh5UE1qSTzr2BhTm/NVQ7DxURW9Cj14x8ELC5XoWLri8QFwrMysyOnxdg92P3/
         B90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=V7R5ZOzee+xNnoboOxnimiekBXFaPMkt2x1jVom81wY=;
        b=rGUzdobEddA59U5IXfz5LxwYlXhmlzXgafn1kzSG0ZFNj7kZJv1+XU60fJBZExlRoK
         uAjQu5d9Bh2NoR88Bu3hbRRdlfjnU5eJsa+DXTqLm7eIZtqhoQawDWKr1HerjsSpLRWr
         wOeBrM7ri8aP2MN9Ro3xCZeWGKZLfEHapcpEgxWVwwliV6HInyFbnefPib2GjiMP6dWr
         gRfdN0CdIDHu2tUqEqLxqz9X4gbSVSuFFzN64v4c+8W0ciLQC9W/XAdPIbpcITjjucQI
         wmbZfs+fjIdBo2denz3+oyhMt+upEa08nQJwNvrtrOz5LSGRzaKV/QR98UQobm0SE/w2
         XuCg==
X-Gm-Message-State: ACgBeo15F4/WunDhlyWnHp6KhqgG5QBi+lgfA9zuPF4u3tLejGJdJrUf
        lCbE1e/CcllLIv+Fluj1g3ZRwCVW8jVnmg==
X-Google-Smtp-Source: AA6agR4QxbcWINqkTPIasNYKWWoCa3b2SRA3y4oXoPH/GOirAH6T5k77cT3Eyc8HgjYM7ACdUOwEMQ==
X-Received: by 2002:a17:90a:b108:b0:1fd:fac2:5a3f with SMTP id z8-20020a17090ab10800b001fdfac25a3fmr6484892pjq.55.1662147162321;
        Fri, 02 Sep 2022 12:32:42 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id k1-20020aa79981000000b00534bb955b36sm2237225pfh.29.2022.09.02.12.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 12:32:41 -0700 (PDT)
Date:   Fri, 2 Sep 2022 13:32:39 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     cgel.zte@gmail.com
Cc:     bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, ye.xingchen@zte.com.cn,
        --cc=zealci@zte.com.cn
Subject: Re: [PATCH linux-next] rpmsg: char: Remove the unneeded result
 variable
Message-ID: <20220902193239.GA1787913@p14s>
References: <20220831164632.GA217472@p14s>
 <20220901053231.312211-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220901053231.312211-1-ye.xingchen@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 05:32:31AM +0000, cgel.zte@gmail.com wrote:
> Thank you for your reply.
> 
> In fact,‘cgel.zte@gmail.com’ is our company's public mail address, and ‘ye.xingchen@zte.com.cn’is my personal mail address in the company.‘ZTE’ is the name of company, and ‘CGEL’the name of our project team in company.
> 
> For some reason, the patchs needs to be reviewed by the company before it is sent out, and we have to use public mailboxes to send mails, because personal mailboxes are not allowed to send mails.
> 
> Because it is the patch I submitted, the mail about the patch will be sent to my personal mailbox through the public mailbox.

Thank you for the clarification - I have applied your patch.

> 
>  
> Thanks,
> YE XINGCHEN

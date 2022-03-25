Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B985F4E6C48
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 02:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357625AbiCYCA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 22:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346335AbiCYCAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 22:00:25 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037423A72E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 18:58:53 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o68-20020a17090a0a4a00b001c686a48263so6438273pjo.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 18:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7UqoxnexRZIYgAmaCT2NR/FFNg3pbUIhHD5KY1C8P0o=;
        b=avCYBKKvdypfuoJNrbhAIMEIcgShk1Zj1USbl3poWtUPT8Bet+mLntrgUKSMss/bh6
         92lgLD5ty7Pdq2r9sxykimbuw1qTH9fvdhiAjnHYjB/W8osj/rVq5wbl3n9tcv2BA4ym
         ytk27+4wen2ceHQDcHck6NQ0n4dBzYM7zcNmfIJzgfuHIkChyjz4TZOlLwwnUxNLiUmv
         LWI4lHe13uN83Zd7vyAzK0YSK8nvZ2DiCIdcEkJO6nUUYIz+2md2TtyEYb3Qza6OaiZq
         rokEQhRpK7j/KhCyzhJN7vZgMxaH0wLvz4q0m+9K9qWhvhLxw7JbzOnLYEPw9wcoKEFd
         iRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7UqoxnexRZIYgAmaCT2NR/FFNg3pbUIhHD5KY1C8P0o=;
        b=jy62chh7LXNx1lGSdIZOzt2fj6Cxxw4LAWtyJPEG/K3joypHKt7Q41/YiFflMZzGjt
         TQnv0WmR6f1xVAjYqV7u+GPNZcyvvN84MP/MOmwQLkHq4UxbHaBO5JBGrjIQrAXYLjoY
         cbw0D4m8/5e6xr8NvG465VGZOhARyfmKHWJBn9Q1zj296cw0Gxhclc83QW3pYVI47w4g
         XdkSJx0II+YyGQOXC0ByPEsqdR/wUc1ze8hqnwI9n8evEK9sV+5dyZAnveVtNvB5LArs
         HRk04qEKGAmFrnLZhfLLffcff2SUBr2aTX5VTx12topUFGfe15eH42e24fJW/oyam70V
         HBrQ==
X-Gm-Message-State: AOAM531OGorkYsmN3d0Dmt6A/IO5zU/BxW1dJSbKw/WMpVLur33ynzTl
        YJrXPHXtQTlu4AdSMFD30cLvsA==
X-Google-Smtp-Source: ABdhPJxZJhn3xGpOGCemBqjUHadgwgd6nBeVTCB5L3NUi0Odrw/tF5FzN0TXzKmg1SnC8nj7Jbx6zQ==
X-Received: by 2002:a17:902:e801:b0:154:19ec:53a2 with SMTP id u1-20020a170902e80100b0015419ec53a2mr8886398plg.151.1648173532485;
        Thu, 24 Mar 2022 18:58:52 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id l185-20020a6388c2000000b0038614ed80c0sm3931676pgd.41.2022.03.24.18.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 18:58:51 -0700 (PDT)
Date:   Fri, 25 Mar 2022 07:28:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: spear13xx: Update SPI dma properties
Message-ID: <20220325015849.sazvlevnvdqj5z42@vireshk-i7>
References: <20220323175920.93155-1-singh.kuldeep87k@gmail.com>
 <20220324023904.h2qfxzxlznggbsyr@vireshk-i7>
 <20220324062547.GA15504@9a2d8922b8f1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324062547.GA15504@9a2d8922b8f1>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-03-22, 11:55, Kuldeep Singh wrote:
> Fixed order of values is important in case of properties like
> compatibles etc. In case of dma-names, yes order shouldn't matter here.
> 
> This patch is more of appeasing dtbs_check warning rather than fixing
> something.

Exactly my point. We have seen similar type of issues with other tools, like
coccinelle, earlier and such patches were rejected as the kernel was just fine
and tooling needs to be fixed.

> It's safe to go with this patch.
> I am not sure if there's a provision to exclude dma-names from fix
> ordering checks. Rob can help here in providing better insights.

-- 
viresh

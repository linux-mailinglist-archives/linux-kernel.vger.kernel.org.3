Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC97576ACA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 01:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbiGOXgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 19:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiGOXgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 19:36:06 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E3113E19;
        Fri, 15 Jul 2022 16:36:02 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e15so3436120wro.5;
        Fri, 15 Jul 2022 16:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=HCNYGow5nVdiUj8HiGxZTHr1Lk6MTCK4vh2T29V1oIg=;
        b=Qcc5wrLPF/njXC8FuWZ6W3lo5Yfu237T82ALxteoHtlauDWpJf9mTmfuvFydtfXyUR
         5j/VqvGP85Iuj8OtgTKFj8mlsY8r50CFZOXru/fWv1qfgO7sK9tV7WmMirzpZsKN5UwW
         7YkBP7bqVhRwZrq69mjlWG5WGuA4RPwp8XiJBt4s0bcOtZ6jlqcOMqo1sXGTpmLYP2KY
         bIfR/2SPA93eQQtcc4Gh7fRITNkVQ97ryPgO7Li1VTqDl/MA//ohEdkjpYF3eOEjipTW
         IPOCAHipK5LlpefuwnC5P5zGNaMWWyd8CW6pFOT+XnDtpIg5BfMqYmb5SctlyktLfMpk
         MUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HCNYGow5nVdiUj8HiGxZTHr1Lk6MTCK4vh2T29V1oIg=;
        b=1s/WivetxUagIamyd0t4CJw8Q+ausx4O0To25I298R0aikflXJiVU/4dLv4cOUVA7t
         phRkqSKaFVC/oAjL+z51E42frRKSz1yLgN9z3w1oznJNkmj/LeS6PS4W+nd7+5gGjT9a
         K3pbw5i/GRY6rfUQqnHZqDWqOLos6XVWBD1BMA8rVWKqHLKt5df7ryrmNv3PP+aQIAEP
         uoQuzfSnaRjEPkOQ6fLXJ7+WjRxafQdqAPU4HA7I5ezXa9sBdqa38PxvS94/2EckD9UX
         50w/Uo16fjRdz3QlwlF//lDUAmkoUgWOpgPA4SPhCBtvzyopOvxJgC4yPzi/Q7PILUu/
         ayjA==
X-Gm-Message-State: AJIora9T9PbJ6Dfam3J4HaaBofWuZvWWX6ABp5psv1oXuzTlSaj30gtn
        cuSH/XF7kg3M/om+nJ8PBgQ=
X-Google-Smtp-Source: AGRyM1vFZEEGxe0/NqO66n84cNHfCFwmZT4A06oMZkgd7GN++rMg200OBDIkjx2TmD6Xff0aOn1owA==
X-Received: by 2002:adf:f705:0:b0:21d:74fa:c043 with SMTP id r5-20020adff705000000b0021d74fac043mr14989190wrp.77.1657928161014;
        Fri, 15 Jul 2022 16:36:01 -0700 (PDT)
Received: from debian (host-78-150-47-22.as13285.net. [78.150.47.22])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c3b1100b003976fbfbf00sm8352791wms.30.2022.07.15.16.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 16:36:00 -0700 (PDT)
Date:   Sat, 16 Jul 2022 00:35:58 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: build failure of next-20220715 due to "No rule to make target"
Message-ID: <YtH53r9UcYwquxcx@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Not sure if it has been reported, builds of arm and arm64 allmodconfig
have failed to build next-20220715 with the error:

make[3]: *** No rule to make target 'drivers/pinctrl/sunxi/pinctrl-sun20i-d1.o', needed by 'drivers/pinctrl/sunxi/built-in.a'.  Stop.


--
Regards
Sudip

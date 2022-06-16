Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6B854DE48
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 11:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbiFPJiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 05:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiFPJiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 05:38:19 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C705335265
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 02:38:15 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id r12so713556vsg.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 02:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=3T0R7KAOGsrGSXpLar7DXmqs1HAsjPtnw9PRokhjqI0=;
        b=h3tMxV9Wd56O73t5+lTO1vgZ7K3LEAleVvdZeVOSE3uwzcQApzllBnhdpAU3/OGbTT
         NUid8ILknU5RpAtNdl02GvvNMFGdy4bkjrbQ4gmGl4JqtrOKSCVdpb0OnpYzdPyQDhsc
         UTuW6ZYTVNM2Ac5f6BP0AZzIyetFbNniQcYxM4upmSO4pF0dg1inf0mPsw+ivVhAIp0C
         xFelmyTXP6mNNagOXsJfAsw5ZFq1eOfIxEjW5gVQ1v27wg73uJPJkcr8XNjmsPaRlX/X
         uonttXjC1UW9GXcSZ19jnkxOtYbWWhOy1cSQeZPIUySMTlJtoSglQ0WmxtKN0PyRx2dG
         WocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=3T0R7KAOGsrGSXpLar7DXmqs1HAsjPtnw9PRokhjqI0=;
        b=O8IuLC/ABgNEERCvzMn0N248J2hp9Q2dtymgCX47KC8387AYqeaSlkbaWQuOP3GwOT
         +enhbtCqcKPhPumDPNIDtJ0LbUArOtTubQ41LN7FDToVFVR0aggkOuKybXuB1UtW2Whv
         Jvhr5be1jgOOK1kK4IS0BnmRqCN9GI3y6+2sAhw6AV1qMBR1Lk5xbsa1UMLKyevpciOs
         QgvcaS/wIPFV2H66rx7I2kQvOrze/XJC/S4Je5LnMgvgefLT+sEQn1Wl+94D3QnBbXRC
         a0xqKJJFMBTBNUWan/A4R/cTA1iFSlx/oi4+Rj/oJQjCZkvmSPq4n3XKDyVG9qJtTRMh
         DHmA==
X-Gm-Message-State: AJIora/xPj4nLMGilzQQ5BYpqSZm9uH0FmpoZ5KAqhWt8AC0MdXA3imB
        YY+nWomfonJjSL8u5yPdoW6khvf4EpS/rSDeXTQ=
X-Google-Smtp-Source: AGRyM1tR96VZhEqEdwFXCfMLy82OVxFzx23pkIWcIY+zGnUMB0kOV5YtkszP+cn2QpdmeZHVpwOtJnzu1xHN6s7fJEk=
X-Received: by 2002:a05:6102:aca:b0:32a:1acf:5ff8 with SMTP id
 m10-20020a0561020aca00b0032a1acf5ff8mr1734274vsh.81.1655372294928; Thu, 16
 Jun 2022 02:38:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:a30d:0:b0:2c7:647f:fab7 with HTTP; Thu, 16 Jun 2022
 02:38:14 -0700 (PDT)
Reply-To: bensonv468@gmail.com
From:   Victoria Linda Benson <almohannadisalem752@gmail.com>
Date:   Thu, 16 Jun 2022 11:38:14 +0200
Message-ID: <CAJEKbO0mS5qXWzmgofF4NCPq6_TSE3YBM=qMYchmAhF7KRViig@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i sent you mail earlier but not sure if you received it. Please
 confirm receipt of this message as I have useful information for you?

 Best regards,

 Mrs.  Victoria Linda Benson

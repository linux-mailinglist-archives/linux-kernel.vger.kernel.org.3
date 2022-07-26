Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7050581679
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239109AbiGZPcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237141AbiGZPcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:32:45 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D26525598
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:32:43 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 6so13416952pgb.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QvgqOJsJaRfwh288RK8fy30Wkh0J6u/9f1tN/TUOFVA=;
        b=NrQhRCOMUDC3mXJXosstgVwIDMYkidDR0/Q8Vw6uHokuZZDKRNeVGoywXSjWMLsSAi
         BqPLLK53Unp4zoisknrJ5o424bakXSL2cC8jAQsP2Der1v23+fwmcypMhH9PEbm7r3Wz
         wZUq758ylpkk1JsIjod8XkkgxvaCtL8hlO5xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QvgqOJsJaRfwh288RK8fy30Wkh0J6u/9f1tN/TUOFVA=;
        b=FeCczossEYTmBU+lSizdV/0sUn6Rd6FFoPs16mg+bpzwrpg97ZC8bDML34rLpLwCnY
         aRdmoVeICW1B/AWLoYYRT8Y6lNQ3bFbvlNpwxyqzfzC4qb9fu0AxzL/mv3zItdHJGp2I
         ESEvDWWLGNWqzYlIDIz3b5EcC4JrLxmwuPT5RdvZtF52DgVFtaqq881DhgvtGhqBgqQG
         fKPhKu69yviP4kEl46AAimzp2WfrJWRZekgqez+Ro1BSdMJikmgVqkHjNzwCaWp/TUVJ
         x7AoTdW0hD7MO6IfHnw3etZR+pTEnGawpcxRy7Xrlht6vjAcwYy2PYg/Unx32A5xtRuE
         02Ag==
X-Gm-Message-State: AJIora8vkRq8osUcWzexITGq+Eby/B84AHW87sE3isJyqRIdVHwdbve8
        YwHQbjT1yyERrFJANulYSK8s9w==
X-Google-Smtp-Source: AGRyM1s00puXzuack0g772HA7Y+ZUTEclrQEjeyTAfQzTXf+aMs/JSmo14i4PletDJvEYqkYsRojGQ==
X-Received: by 2002:a65:6e96:0:b0:415:5973:b4f4 with SMTP id bm22-20020a656e96000000b004155973b4f4mr14939446pgb.568.1658849562682;
        Tue, 26 Jul 2022 08:32:42 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:e9b1:f865:ec5d:495e])
        by smtp.gmail.com with UTF8SMTPSA id ne16-20020a17090b375000b001f3009a5ccfsm564197pjb.54.2022.07.26.08.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 08:32:42 -0700 (PDT)
Date:   Tue, 26 Jul 2022 08:32:40 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        alexandre.torgue@foss.st.com, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, amelie.delaunay@foss.st.com
Subject: Re: [PATCH v2 2/4] usb: misc: onboard-hub: add support for Microchip
 USB2514B USB 2.0 hub
Message-ID: <YuAJGBmX3Bf5Y1qf@google.com>
References: <20220726080708.162547-1-fabrice.gasnier@foss.st.com>
 <20220726080708.162547-3-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220726080708.162547-3-fabrice.gasnier@foss.st.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 10:07:06AM +0200, Fabrice Gasnier wrote:
> Add support for Microchip USB2514B USB 2.0 hub to the onboard usb hub
> driver. Adopt the generic usb-device compatible ("usbVID,PID").
> Some STM32MP1 boards have this hub on-board, with a supply that needs to
> be enabled for proper operation.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Acked-by: Matthias Kaehlcke <mka@chromium.org>

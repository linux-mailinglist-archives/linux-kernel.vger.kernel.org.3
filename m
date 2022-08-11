Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FA55908FC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 01:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbiHKXNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 19:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbiHKXM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:12:58 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7EAA0626;
        Thu, 11 Aug 2022 16:12:58 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id q19so17725265pfg.8;
        Thu, 11 Aug 2022 16:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=PpG45tAjR9YDDIIsUsUc4hkOxxFDKn8sC4x3rC64w2U=;
        b=gyWpN+OQnfBrGp5X0QM+Uw6qRwD9p7Ydh5bCrG7eFrK3Zpmj3vOAG8M9o9ez+S68Hh
         S+PMaVp4JKr2tSOjlhxbLRIJZmJPDjuG0dVaHKknbbFroCMa/IDsQSSEJgsrPVzjxDk1
         D4a4z0qlffA+R7KHJ5zHqDIS03RQRPk1t7tgoipYjsyvFsNZT5EKYrdd7mCvxFLoRPyl
         wDWp2/WTGR25vsXIX8iYNiCAM4WyFrsoRseVgbxpaX6itqR8t4zopjJpbnXQ9ZtBGHM7
         +mVl1jnRL+N9hFmO1qt1jF5X3COcshvQ+8DujjbplDlQrkfdQcwbswtfwYV2cI9w6NAv
         lC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=PpG45tAjR9YDDIIsUsUc4hkOxxFDKn8sC4x3rC64w2U=;
        b=BbB2yJo8BS68Ys11dIApbSCCRQDhxnukb0srKoavAB8ZTLnhnfmtwMh4hxv21vd5Nf
         5BOjPYI9XdtX4oM78pHUeP9XoLpjLkyfHLk63mWkHZWnsWg72wjHEe9Mq3uhpx3bp9hD
         Nok911XdRt22C4Jj0H7RgclBQz+pmEPL9KTFd9+CmJq9tIgSKIv7vhMjedyVb+NezEiS
         ASXUW4U2GUmfsB5wG1WDo6aS8/0CuaotJfcNfQWEyixRMxz6OcQLbuB+8VBsuBbaGOFf
         PW8921i1FEbUpUEX9Cc9X2GWhOFNTh0f/Gdk/PVPvv8EqhPvRVBFQNzpIJDBBWPs2Tjl
         S4zQ==
X-Gm-Message-State: ACgBeo1pcSSlKsz22M717CkEqoWwICO0Y+37sHpuyeDlAICGpfYPys1J
        tY5pxgpnMJ5Mnx9OrdugcrVro0o9zq4=
X-Google-Smtp-Source: AA6agR5eL9RxRIfaHUoNj9kMe6HuJcWTPUhl0eG+/e6JSq90BG5wiQKpZLWz+8cNTcbrZc4hl1l3mQ==
X-Received: by 2002:a63:1e09:0:b0:41d:a570:96bc with SMTP id e9-20020a631e09000000b0041da57096bcmr1000715pge.78.1660259577550;
        Thu, 11 Aug 2022 16:12:57 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:c348:229d:7b9:f9dd])
        by smtp.gmail.com with ESMTPSA id y24-20020a631818000000b004202cb1c491sm260805pgl.31.2022.08.11.16.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 16:12:56 -0700 (PDT)
Date:   Thu, 11 Aug 2022 16:12:54 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] Input: applespi: Use correct struct names in comment
Message-ID: <YvWM9hm7Tfeq+1oe@google.com>
References: <20220805174754.2374473-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805174754.2374473-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 06:47:54PM +0100, Colin Ian King wrote:
> The incorrect structure name is being used in the comment for struct
> touchpad_info_protocol. Correct it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied, thank you.

-- 
Dmitry

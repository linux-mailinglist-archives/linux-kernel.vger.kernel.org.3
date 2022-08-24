Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72FF59F66B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbiHXJgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236401AbiHXJga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:36:30 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C26D95E78
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 02:36:26 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3246910dac3so444891357b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 02:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=aqKb1J0sUYKRxFSx8BTKcr3FtUOkogBHLhJ4EzMaqDI=;
        b=frLiu8gAjQ0kpxVUy9iux+0KZBGaas40KedmyZg1S18F99UNtbnKu4hhRcDttjsiJd
         0CwO3QisP0/EAOdV209Ke7wOk79MP83THWvb1oOu8ufAVd3wpqg8eBBxrJaXcD7lG8M2
         QCkTI9ixDBfjW6AfbuxNQqr+KvY7jj9h7ZgpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=aqKb1J0sUYKRxFSx8BTKcr3FtUOkogBHLhJ4EzMaqDI=;
        b=CoTW6kkUTfv7A1Cay69Fun1PcqKn0Fa+GQ5Jlv0n1A9DqHA3ulPaANPeLNX6Fz2G1n
         QPDyMErazy46zNCqyXDbYCpv/EdGq/LTnNo37HPqEGPh4DX6RE+Nl3tmKunii4NfIrqJ
         ASka4r/FjfRksOoa8uM54jnlBnwnq8Px1/b6meIbj62QFRZwEhkTF6Pu9c7gV0kej6JN
         cpoy0LHbQcJHS/Z6sH6uXGIl5iwrkbiGi+tKiidKPHbZhAvmTCNtUUiHNHrZWtntgr7K
         27SoBrtN82ltWcILmUVabqaBebIeMzTNFIAJ77387vktz/XfK9PwKqJEaWw8jrKI9Kft
         1RdQ==
X-Gm-Message-State: ACgBeo35PFv8ruGSJ/xDzeO84oMtlkoBj5hDiDcHrE+zSnm9U04MiNFe
        Ee99hsaz+uDcXfePp3lXcmz52KA5HbRHeE8/BVTjSQ==
X-Google-Smtp-Source: AA6agR5u4zZdD5BUdh1+uP1ur82Idc4dh5due5UwgX6YLLUPiWMyvuRnCFUobBbL4xkzsp3eJyxT/mfgO5BtEv9ddcc=
X-Received: by 2002:a0d:d897:0:b0:33d:1aa7:2425 with SMTP id
 a145-20020a0dd897000000b0033d1aa72425mr11107499ywe.224.1661333785427; Wed, 24
 Aug 2022 02:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <1655727966-31584-1-git-send-email-Arthur.Simchaev@wdc.com>
 <YvBK/8yeohLhu2Za@google.com> <BY5PR04MB6327431615BFFFD735EB2502ED6B9@BY5PR04MB6327.namprd04.prod.outlook.com>
In-Reply-To: <BY5PR04MB6327431615BFFFD735EB2502ED6B9@BY5PR04MB6327.namprd04.prod.outlook.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Wed, 24 Aug 2022 19:36:14 +1000
Message-ID: <CAONX=-cXDcekWznHf6h1WwtJfELyFxSPAZ4bnA5t3xOrmUQZ5Q@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs-bsg: Remove ufs_bsg_get_query_desc_size function
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>
Cc:     "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Daniil Lunev <dlunev@chromium.org>

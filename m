Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970975A8415
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiHaRQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiHaRQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:16:48 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A73BCC25;
        Wed, 31 Aug 2022 10:16:46 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y29so10998204pfq.0;
        Wed, 31 Aug 2022 10:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=paKgsrrjfrseC4rmD4ui+X0SxIpQJQSuRF5Ht98Hcso=;
        b=I/XHko3hm6MDQF98JoDAVlmcjIo3WNWrhjxOETaBFcAtKbD82jyd+mqvjWX3Y2r9x4
         H8R40hN02xkDsmZnH0Bsq3rid1JhvOzbKRi+5tUueHYnApe48s6aluHLJlJKd8lJu7g0
         LfhNSxGCv+fb7LC/gSoHbUlWnbtKDCwQpMiyeAWcq/5ywDJU6Sba0QtnaBtMp6C7EF1D
         MsMeEMrSkGF5xLCW36LsLBJHCV+vcw+0RieLGTjo9kZDcV59EK+2VmuweA67KRpfM5oI
         yKWFSStgctTOdPUbw9w2s9FvEXF09ZqbIdEBjDGz81C26cOvsvXOnl/5zoYaeuJuQeAL
         SirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=paKgsrrjfrseC4rmD4ui+X0SxIpQJQSuRF5Ht98Hcso=;
        b=ogc1WqE0Xld2W3jRzflcThwSnBlKWLv3dcH+v48vQLy/pw5m+pPMz77mWs8s/WkWSR
         wexFdi7JSu9Ya/vfniOuHRQMLo+GCpejZzi9xNwXweKKvD9SHkJQbiIuCEMB7OymmwZa
         860zQNerCfL90lsStElAs2mgep/ZIelGlgUWdQfZ+8aRzI1G19Y/gq20YqGk359k61PI
         izplqt6bT30QE9k9NHCi+oTFKVbdH8mAPf6E3E9PIYPzxgO15doESkE9eOdM0SSiCuVE
         NauxMIu4FEChNYJHmI/ihOwjYDP3NSKflBxLbVeWbuBqhmJ6InM0jTj2vE66OX2DVJja
         TEXA==
X-Gm-Message-State: ACgBeo3hTwl/17vQfy0Po7bknuMK/qTebzBkHHDXg6s/K7xUJIM8/7TL
        J9urH+WQjQ8RwKXXOM8r3LM=
X-Google-Smtp-Source: AA6agR57xaq96hfsoPtEt8NLYQiydI9wY9tGneEcMbUdZPfV0NMVPoaPaOyNzUfwYiBV+4N686b9tA==
X-Received: by 2002:a62:4ec8:0:b0:538:3dea:2518 with SMTP id c191-20020a624ec8000000b005383dea2518mr15519728pfb.39.1661966206231;
        Wed, 31 Aug 2022 10:16:46 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:2488:79db:897a:5de7])
        by smtp.gmail.com with ESMTPSA id ot17-20020a17090b3b5100b001fb3522d53asm1563099pjb.34.2022.08.31.10.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 10:16:45 -0700 (PDT)
Date:   Wed, 31 Aug 2022 10:16:42 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] Input: touchscreen: colibri-vf50-ts: don't depend
 on VF610_ADC
Message-ID: <Yw+Xeh83mNR9kUKP@google.com>
References: <20220712101619.326120-1-francesco.dolcini@toradex.com>
 <20220712101619.326120-2-francesco.dolcini@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712101619.326120-2-francesco.dolcini@toradex.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 12:16:18PM +0200, Francesco Dolcini wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> Any IIO ADC can be used with the driver, so do not depend
> on VF610_ADC.
> 
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Applied, thank you.

-- 
Dmitry

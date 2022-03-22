Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F474E3F0B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbiCVNDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbiCVNDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:03:18 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11A076E1F;
        Tue, 22 Mar 2022 06:01:50 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id b18so4533985qtk.13;
        Tue, 22 Mar 2022 06:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=is2ofUDOuXA6bsKi4vpINE5E6h7MsI9LhgGJ4eXJ3Ws=;
        b=NJkyt54bHF3/ZG0kSxL2LY/nzNg0WCs/L3IPxfKBEKjfhGOzkqLL0AFcJ88GXVu6sG
         g6Mqy75+rbXQ7iR/CFNNXRgbFIumy8aBl+wUag0BzO3LeInLcqkOBzJBxt5uFkCH4s+j
         QDNsWvk8xUdDIiywmWKd5txhjhsCTqGtjOfwuNPz+FwyRopMJBAem/onu7SjczlgJ/mE
         QKGJuXuBzA5GbW9LBdMBYmB5Msqepq+xwCyA4akD19TiNWpOIE7eEflvOMv/tpYnRMz7
         FtKwvwFaTig3+qIWci/3ZAxpiICVLwaY1DOFDOit9naCiuwUvabWy6XQSssYjXiXZ//e
         Dziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=is2ofUDOuXA6bsKi4vpINE5E6h7MsI9LhgGJ4eXJ3Ws=;
        b=e56XB0YGpjIy82IrhDG5NvMG874xbwHLsdu/9A9pAdF5OUlClFZOmveNmL4NoKNDRN
         eCQty6P1zcep+Y+3grNnmXam4ZzKsj7ZMD0t8xSVVzW0jVGiuVBobpABtl90D+0wUvr1
         yGUKYFeevOopRrFl+dTIG1ZwCuH93BabF6QCmST0Z74C7xLvYQNusvGF/aYkarThk8yL
         xSwJ5otG1UO4zJivfczj7ldYkV/tBkyrAfg+A0aGF35VCyc3MbRRIt68Xz4xsUS74har
         6sB5vWUt061ak5sjnTacE6EecFOHlSehVFtOi4DA6GoVqDN37vLso4ryXvg6lJe45g6x
         BtgQ==
X-Gm-Message-State: AOAM532iAVH2h3qPQYyiLd24sG+Jm4chyY5sFCqYlAGRvHvNWuwRi+J6
        tsQ3bK9CEfaI9pOwl5aoQGA=
X-Google-Smtp-Source: ABdhPJzmmC+0uRIWzXxtpvkscY7F3KMR8n2Wlxx8/PvigyuxIr24VzEORpylIhx7QMw/arMMR8o79Q==
X-Received: by 2002:ac8:5ac3:0:b0:2e1:e117:b2ed with SMTP id d3-20020ac85ac3000000b002e1e117b2edmr19719378qtd.541.1647954109450;
        Tue, 22 Mar 2022 06:01:49 -0700 (PDT)
Received: from vps.qemfd.net (vps.qemfd.net. [173.230.130.29])
        by smtp.gmail.com with ESMTPSA id k6-20020a378806000000b0064915d9584fsm8988748qkd.8.2022.03.22.06.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 06:01:48 -0700 (PDT)
Received: from schwarzgerat.orthanc (schwarzgerat.danknet [192.168.128.2])
        by vps.qemfd.net (Postfix) with ESMTP id 405D02B525;
        Tue, 22 Mar 2022 09:01:48 -0400 (EDT)
Received: by schwarzgerat.orthanc (Postfix, from userid 1000)
        id 3C5BC6002D6; Tue, 22 Mar 2022 09:01:48 -0400 (EDT)
Date:   Tue, 22 Mar 2022 09:01:48 -0400
From:   nick black <dankamongmen@gmail.com>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     "G. Branden Robinson" <g.branden.robinson@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [patch] console_codes.4: ffix
Message-ID: <YjnIvPaZBAaE6jmH@schwarzgerat.orthanc>
References: <YeEc2pYvKEckcAmv@schwarzgerat.orthanc>
 <CAN4uE+p-uKzHNYry2YhCMfEFBQ2jUqpDAGx=+eha01w-L4fAjg@mail.gmail.com>
 <20220320160217.gws42lklp6ishzub@localhost.localdomain>
 <fd0b3fea-4b40-ffba-442f-00908a5335a9@gmail.com>
 <Yjg3jXCAsjQVHJAi@schwarzgerat.orthanc>
 <809c40c4-068b-8296-57d9-024e6623362d@gmail.com>
 <YjnHmiYL50SqHCW/@schwarzgerat.orthanc>
 <456bc9a8-cb58-c9ef-b1b3-3671ac34a2dc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <456bc9a8-cb58-c9ef-b1b3-3671ac34a2dc@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alejandro Colomar (man-pages) left as an exercise for the reader:
> If it repeats, I'll try to investigate the reason.

or i can just make sure i'm sending the expected format--it
ought not be beyond my powers =]. thanks for bringing this to my
attention.

-- 
nick black -=- https://www.nick-black.com
to make an apple pie from scratch,
you need first invent a universe.

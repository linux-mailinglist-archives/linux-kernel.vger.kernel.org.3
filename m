Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039864C141E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240906AbiBWN3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbiBWN3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:29:09 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EF3AA023
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 05:28:41 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d28so11877763wra.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 05:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=pSKuz9BJS/Qwel4yBJUKsJP++c1z8gtIosTtEbMtN5I=;
        b=OFnpZaWUe1aj3quu8873cjK2E4SCrW3jC+uJ5IdQ8OFBWaJqb1qtvX35eq6AzwZSOL
         Uo7tZ1bEiqcpGqWUHAaxFasSotwhTi/yMfwW1vHh+5+1rhC/0/EM2cPMmCdiBwNUAn6D
         Fjh2uIYNAGqZgGOPghNV+MqGpI9TT2Q7u7qoTAzg8jAIxMcBIbsDO5wYjk6YUEuR3KLT
         sSGUh+PZY82YFx4ceFP3KXcQlizafaN0fOVUXXqdVwlyaf10VMJWO3MmIWubxC252Zer
         P3EfkGQV4MxglyVYy/aLJNnugrwayzdNPbbHdW24HpVCbBSeFkT20JzTHokGiGGDTOhR
         thXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=pSKuz9BJS/Qwel4yBJUKsJP++c1z8gtIosTtEbMtN5I=;
        b=0ItQhp0MMsVNoO353Z1ULV1TbGsGZd4AxgvDtXJua6JICcvETynsWbyTJwuN1+7fVz
         vBMypq2kVFtGL5EKA7VvdPru4aTErnyXmSCR5KTnSY3i5p7Tg63Q1ZTdcybVyQl5kAdL
         XdTEUMRUb8wlrmAynhzYoryPHqn+/t0ZX2dktBmLJO4grfhkHHo3C9uYMOExj31xM7tQ
         nt3jeV3sx3QflgTqF4rlUpyOf8G8VbYTmodSWa/c6lcxLqg59i/+YArYF4ZsplcB+IY5
         BJpuxEAyoHc4c7e2orBjM1QEy+4Jitemzi+HBXdeCnIUR5+LcDe8wC+p+JB9dUrTvhDM
         407g==
X-Gm-Message-State: AOAM53268Cge1I92FoLiEVCOcYQP2b0G3t7MN6F1wrdlOZ3zSvMhcz1P
        8P2E/oZRs3dRRaNO+rAmSaGHL7Bcu2dBjW3V6eU=
X-Google-Smtp-Source: ABdhPJxaS3glusJ90vEklcmE3OoVGBWrat6v4bOpgc89thvvaLzRPcmLbpB6Z0z7eGkhSHgk16GeGZxR1mQlLI2VXFI=
X-Received: by 2002:a5d:4bc8:0:b0:1e4:a4a2:63b0 with SMTP id
 l8-20020a5d4bc8000000b001e4a4a263b0mr22062511wrt.596.1645622920503; Wed, 23
 Feb 2022 05:28:40 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6020:c266:b0:19d:b465:fa86 with HTTP; Wed, 23 Feb 2022
 05:28:40 -0800 (PST)
Reply-To: davidnelson7702626@gmail.com
From:   ADELEKE ADEROGBA <jamiuadeleke821@gmail.com>
Date:   Wed, 23 Feb 2022 14:28:40 +0100
Message-ID: <CACFefoGeJp3n_fkj2P2UCz27euwDsqdOnBX7WMo-OBVC2T=AAA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello friend, I want to send money to you to enable me invest in your
country get back to me if you are interested.

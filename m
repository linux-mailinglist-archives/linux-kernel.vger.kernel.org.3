Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B8A48B095
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245757AbiAKPOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:14:54 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:37699 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiAKPOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:14:53 -0500
Received: by mail-ot1-f53.google.com with SMTP id h20-20020a9d6f94000000b0059100e01744so1974870otq.4;
        Tue, 11 Jan 2022 07:14:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=H5aXFc3cTbqVbXAscJ8U7IrcuiVGZ2Ji9H3Um66jTps=;
        b=7XaxXXNhYhSg69LdnOOeSr8H0Pk+bfhDAnOqT+7qRHZ29HajyWMapF6JCUZMhwxDzh
         Jf5viOCTBpws5Kl301Pm6e77YeBlEK9gb7b6E5GwahE3KaCOVrYywNOyz3xqLRQ5zP8n
         9goaUS1CCf0wNldAIPHBA59yyGHR2uUKC1z3TCOk3b7YzXe1Mrgc2V37JWRYpwJNUCPp
         oPGLACSDfwxFSlFApV4yBgc9rU/+chX3koTdhUQSgJEJAOUg/Jjzw9cWIuhIFsrD7jkc
         EO9yYqi7oMpLe4it1dK+3dRU/MGY5RX4cdDDQgyUW58cHKPPI/Xm6987GiupXqJOAEIO
         pVDg==
X-Gm-Message-State: AOAM533hka0GZGObqqzDmJaHR3VWjNbCzFTOuJS+usUvl7TqgacJvwOM
        cL66NnDo4b6j7n+71wMGWw==
X-Google-Smtp-Source: ABdhPJxOa21BbGALyE4de7BK9kyi2XavjSItN8TUDfHHHGzgfxNo02m5/Yq7yGoooGkxiPWUljlFsg==
X-Received: by 2002:a05:6830:1e10:: with SMTP id s16mr3550212otr.259.1641914092570;
        Tue, 11 Jan 2022 07:14:52 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x14sm205238oiv.39.2022.01.11.07.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 07:14:51 -0800 (PST)
Received: (nullmailer pid 2944756 invoked by uid 1000);
        Tue, 11 Jan 2022 15:14:49 -0000
From:   Rob Herring <robh@kernel.org>
To:     Daniel Beer <daniel.beer@igorinstitute.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org,
        Derek Simkowiak <derek.simkowiak@igorinstitute.com>,
        linux-kernel@vger.kernel.org, Andy Liu <andy-liu@ti.com>,
        devicetree@vger.kernel.org
In-Reply-To: <61dccc5c.1c69fb81.9af91.0df6@mx.google.com>
References: <61dccc5c.1c69fb81.9af91.0df6@mx.google.com>
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: add bindings for TI TAS5805M.
Date:   Tue, 11 Jan 2022 09:14:49 -0600
Message-Id: <1641914089.172148.2944755.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 13:00:09 +1300, Daniel Beer wrote:
> The TAS5805M is a class D speaker amplifier with integrated DSP. The
> example here includes a tested flat configuration for mono (PBTL)
> output.
> 
> Signed-off-by: Daniel Beer <daniel.beer@igorinstitute.com>
> ---
>  .../devicetree/bindings/sound/tas5805m.yaml   | 201 ++++++++++++++++++
>  1 file changed, 201 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/tas5805m.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/sound/tas5805m.yaml:44:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/sound/tas5805m.yaml:  while scanning a block scalar
  in "<unicode string>", line 41, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 44, column 1
make[1]: *** Deleting file 'Documentation/devicetree/bindings/sound/tas5805m.example.dts'
Traceback (most recent call last):
  File "/usr/local/bin/dt-extract-example", line 46, in <module>
    binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 434, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 119, in get_single_data
    node = self.composer.get_single_node()
  File "_ruamel_yaml.pyx", line 706, in _ruamel_yaml.CParser.get_single_node
  File "_ruamel_yaml.pyx", line 724, in _ruamel_yaml.CParser._compose_document
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 773, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 848, in _ruamel_yaml.CParser._compose_sequence_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.scanner.ScannerError: while scanning a block scalar
  in "<unicode string>", line 41, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 44, column 1
make[1]: *** [Documentation/devicetree/bindings/Makefile:25: Documentation/devicetree/bindings/sound/tas5805m.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/tas5805m.yaml: ignoring, error parsing file
make: *** [Makefile:1413: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1578223

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

